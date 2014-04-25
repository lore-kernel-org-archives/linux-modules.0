MIME-Version: 1.0
In-Reply-To: <53484327.5Nr2aWdyWz5+36kD%matwey.kornilov@gmail.com>
References: <53484327.5Nr2aWdyWz5+36kD%matwey.kornilov@gmail.com>
Date: Fri, 25 Apr 2014 00:46:02 -0300
Message-ID: <CAKi4VALtbKS=wj1KncN+kt+5hRPLDYxzkuDDg-3Cm+wr2mK5JQ@mail.gmail.com>
Subject: Re: [PATCH] Fix recursion loop in mod_count_all_dependencies()
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: matwey.kornilov@gmail.com
Cc: linux-modules <linux-modules@vger.kernel.org>, barbieri@gmail.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi

On Fri, Apr 11, 2014 at 4:31 PM,  <matwey.kornilov@gmail.com> wrote:
> From 48d4d7ba1acbb5c0955f75c6bdda9cf0935240fd Mon Sep 17 00:00:00 2001
> From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
> Date: Fri, 11 Apr 2014 19:43:18 +0400
> Subject: [PATCH] Fix recursion loop in mod_count_all_dependencies() when
>  subgraph has a cycle.
>
> When cycle is detected in mod_count_all_dependencies, use total count of
> modules as an upper bound of needed memory. Correct number of nodes is determined by
> subsequent call of mod_fill_all_unique_dependencies().

We should deal with this already in depmod_calculate_dependencies(),
otherwise I'd say it would be a bug there. How did you reproduce it?


Gustavo, could you take a look on the patch below?

--
Lucas De Marchi

> ---
>  tools/depmod.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/tools/depmod.c b/tools/depmod.c
> index 1aedaaf..c83dee1 100644
> --- a/tools/depmod.c
> +++ b/tools/depmod.c
> @@ -1682,12 +1682,20 @@ static int depmod_load(struct depmod *depmod)
>         return 0;
>  }
>
> -static size_t mod_count_all_dependencies(const struct mod *mod)
> +static size_t mod_count_all_dependencies(const struct mod *mod, size_t upper_bound)
>  {
>         size_t i, count = 0;
> +       /* cycle is detected */
> +       if (mod->dep_loop)
> +               return upper_bound;
> +
>         for (i = 0; i < mod->deps.count; i++) {
>                 const struct mod *d = mod->deps.array[i];
> -               count += 1 + mod_count_all_dependencies(d);
> +               const size_t child = mod_count_all_dependencies(d, upper_bound);
> +               if(child == upper_bound)
> +                       return child;
> +
> +               count += 1 + child;
>         }
>         return count;
>  }
> @@ -1722,12 +1730,12 @@ static int mod_fill_all_unique_dependencies(const struct mod *mod, const struct
>         return err;
>  }
>
> -static const struct mod **mod_get_all_sorted_dependencies(const struct mod *mod, size_t *n_deps)
> +static const struct mod **mod_get_all_sorted_dependencies(const struct mod *mod, size_t *n_deps, size_t count)
>  {
>         const struct mod **deps;
>         size_t last = 0;
>
> -       *n_deps = mod_count_all_dependencies(mod);
> +       *n_deps = mod_count_all_dependencies(mod, count);
>         if (*n_deps == 0)
>                 return NULL;
>
> @@ -1771,7 +1779,7 @@ static int output_deps(struct depmod *depmod, FILE *out)
>                 if (mod->deps.count == 0)
>                         goto end;
>
> -               deps = mod_get_all_sorted_dependencies(mod, &n_deps);
> +               deps = mod_get_all_sorted_dependencies(mod, &n_deps, depmod->modules.count);
>                 if (deps == NULL) {
>                         ERR("could not get all sorted dependencies of %s\n", p);
>                         goto end;
> @@ -1819,7 +1827,7 @@ static int output_deps_bin(struct depmod *depmod, FILE *out)
>                         continue;
>                 }
>
> -               deps = mod_get_all_sorted_dependencies(mod, &n_deps);
> +               deps = mod_get_all_sorted_dependencies(mod, &n_deps, depmod->modules.count);
>                 if (deps == NULL && n_deps > 0) {
>                         ERR("could not get all sorted dependencies of %s\n", p);
>                         continue;
> --
> 1.8.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-modules" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
