MIME-Version: 1.0
In-Reply-To: <1478864601-3259-4-git-send-email-yauheni.kaliuta@redhat.com>
References: <1478683053.4155.8.camel@suse.com>
	<1478864601-3259-1-git-send-email-yauheni.kaliuta@redhat.com>
	<1478864601-3259-4-git-send-email-yauheni.kaliuta@redhat.com>
Date: Mon, 13 Feb 2017 00:30:53 -0800
Message-ID: <CAKi4VAKJUzXptH0AQARsP=H2dxQfuQOHaR1ERCHsE87_ewMx=g@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] depmod: handle nested loops
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: linux-modules <linux-modules@vger.kernel.org>,
	Mian Yousaf Kaukab <yousaf.kaukab@suse.com>, bjorn.andersson@linaro.org,
	Jessica Yu <jeyu@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Fri, Nov 11, 2016 at 3:43 AM, Yauheni Kaliuta
<yauheni.kaliuta@redhat.com> wrote:
> This is a rework of depmod report cycles logic to make it
> tolerant to more complex loops.
>
> The patch tries to remember own path for vertexes which makes it
> possible to handle configurations with common edges and
> non-cyclic modules.
>
> It assumes that the previous dependency calculations can not give
> as input something like
>
> mod_a -> mod_b -> <loop>, but
>
> <loop> -> mod_a -> mod_b should be fine.
>
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
>  tools/depmod.c | 287 ++++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 204 insertions(+), 83 deletions(-)
>
> diff --git a/tools/depmod.c b/tools/depmod.c
> index f2b370f146bb..c110635ff517 100644
> --- a/tools/depmod.c
> +++ b/tools/depmod.c
> @@ -785,6 +785,7 @@ static void cfg_free(struct cfg *cfg)
>
>
>  /* depmod calculations ***********************************************/
> +struct vertex;
>  struct mod {
>         struct kmod_module *kmod;
>         char *path;
> @@ -800,6 +801,7 @@ struct mod {
>         uint16_t idx; /* index in depmod->modules.array */
>         uint16_t users; /* how many modules depend on this one */
>         bool visited; /* helper field to report cycles */
> +       struct vertex *vertex; /* helper field to report cycles */
>         char modname[];
>  };
>
> @@ -1450,105 +1452,225 @@ static void depmod_sort_dependencies(struct depmod *depmod)
>         }
>  }
>
> -static void depmod_report_cycles(struct depmod *depmod, uint16_t n_mods,
> -                                uint16_t n_roots, uint16_t *users,
> -                                uint16_t *stack, uint16_t *edges)
> +struct vertex {
> +       struct vertex *parent;
> +       struct mod *mod;
> +};
> +
> +static struct vertex *vertex_new(struct mod *mod, struct vertex *parent)
> +{
> +       struct vertex *v;
> +
> +       v = malloc(sizeof(*v));
> +       if (v == NULL)
> +               return NULL;
> +
> +       v->parent = parent;
> +       v->mod = mod;
> +       return v;
> +}
> +
> +static void depmod_list_remove_data(struct kmod_list **list, void *data)
> +{
> +       struct kmod_list *l;
> +
> +       l = kmod_list_remove_data(*list, data);
> +       *list = l;
> +}
> +
> +static void depmod_report_one_cycle(struct depmod *depmod,
> +                                   struct vertex *vertex,
> +                                   struct kmod_list **roots,
> +                                   struct hash *loop_set)
>  {
>         const char sep[] = " -> ";
> -       int ir = 0;
> -       int num_cyclic = 0;
> +       size_t sz;
> +       char *buf;
> +       struct array reverse;
> +       int i;
> +       int n;
> +       struct vertex *v;
>
> -       while (n_roots > 0) {
> -               int is, ie;
> +       array_init(&reverse, 2);

In a loop we will usually have more than 2 modules involved so this should be 3.


>
> -               for (; ir < n_mods; ir++) {
> -                       if (users[ir] > 0) {
> -                               break;
> -                       }
> +       sz = 0;
> +       for (v = vertex->parent, n = 0;
> +            v != NULL;
> +            v = v->parent, n++) {
> +
> +               sz += v->mod->modnamesz - 1;
> +               array_append(&reverse, v);
> +               hash_add(loop_set, v->mod->modname, NULL);
> +       }
> +       sz += vertex->mod->modnamesz - 1;
> +
> +       buf = malloc(sz + n * strlen(sep) + 1);
> +
> +       sz = 0;
> +       for (i = reverse.count - 1; i >= 0; i--) {
> +               v = reverse.array[i];
> +
> +               strcpy(buf + sz, v->mod->modname);

memcpy() here suffices since we have the str len on modnamesz.

size_t len = v->mod->modnamesz - 1;
memcpy(buf + sz, v->mod->modname, len);
sz + = len;


> +static int depmod_report_cycles_from_root(struct depmod *depmod,
> +                                         struct mod *root_mod,
> +                                         struct kmod_list **roots,
> +                                         void **stack,
> +                                         size_t stack_size,
> +                                         struct hash *loop_set)
> +{
> +       struct kmod_list *free_list = NULL; /* struct vertex */
> +       struct kmod_list *l;
> +       struct vertex *root;
> +       struct vertex *vertex;
> +       struct vertex *v;
> +       struct mod *m;
> +       struct mod **itr, **itr_end;
> +       size_t is;
> +
> +       root = vertex_new(root_mod, NULL);
> +       if (root == NULL) {
> +               ERR("No memory to report cycles\n");
> +               return -ENOMEM;
> +       }
> +
> +       l = kmod_list_append(free_list, root);
> +       if (l == NULL) {
> +               ERR("No memory to report cycles\n");
> +               return -ENOMEM;
> +       }
> +       free_list = l;
> +
> +       is = 0;
> +       stack[is++] = (void *)root;
> +
> +       while (is > 0) {
> +               vertex = stack[--is];
> +               m = vertex->mod;
> +               /*
> +                * because of the topological sort we can start only
> +                * from part of a loop or from a branch after a loop
> +                */
> +               if (m->visited && m == root->mod) {
> +                       depmod_report_one_cycle(depmod, vertex,
> +                                               roots, loop_set);
> +                       continue;
>                 }
>
> -               if (ir >= n_mods)
> -                       break;
> +               m->visited = true;
> +               if (m->deps.count == 0) {
> +                       /*
> +                        * boundary condition: if there is more than one
> +                        * single node branch (not a loop), it is
> +                        * recognized as a loop by the code above:
> +                        * m->visited because more then one,
> +                        * m == root->mod because it is a single node.

This needs to be rephrased removing the 2 because.

> --

Rest looks good.

thanks
Lucas De Marchi
