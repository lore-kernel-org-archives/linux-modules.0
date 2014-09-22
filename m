MIME-Version: 1.0
In-Reply-To: <1411345254-239686-1-git-send-email-crrodriguez@opensuse.org>
References: <1411345254-239686-1-git-send-email-crrodriguez@opensuse.org>
Date: Mon, 22 Sep 2014 08:39:52 -0300
Message-ID: <CAKi4VAJs5OoU9wouvgw6Q-UXYKEHeCofZM=znR=Q388UWc1THA@mail.gmail.com>
Subject: Re: [PATCH] depmod: always initialize "deps" in mod_get_all_sorted_dependencies()
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: =?UTF-8?Q?Cristian_Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Sun, Sep 21, 2014 at 9:20 PM, Cristian Rodr=C3=ADguez
<crrodriguez@opensuse.org> wrote:
> Fixed Coverity CID #48861
> ---

Is there anything being really fixed here?

>  tools/depmod.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/depmod.c b/tools/depmod.c
> index e90ff83..bcefa09 100644
> --- a/tools/depmod.c
> +++ b/tools/depmod.c
> @@ -1798,14 +1798,14 @@ static int mod_fill_all_unique_dependencies(const=
 struct mod *mod, const struct
>
>  static const struct mod **mod_get_all_sorted_dependencies(const struct m=
od *mod, size_t *n_deps)
>  {
> -       const struct mod **deps;
> +       const struct mod **deps =3D NULL;

you are assigning deps to the return of malloc below.

>         size_t last =3D 0;
>
>         *n_deps =3D mod_count_all_dependencies(mod);
>         if (*n_deps =3D=3D 0)
>                 return NULL;
>
> -       deps =3D malloc(sizeof(struct mod *) * (*n_deps));
> +       deps =3D calloc(1, sizeof(struct mod *) * (*n_deps));

and we are supposed to fill n_deps in
mod_fill_all_unique_dependencies() so there's no point in initializing
them to 0 here.

--=20

Lucas De Marchi
