MIME-Version: 1.0
In-Reply-To: <1478623550-18716-2-git-send-email-yousaf.kaukab@suse.com>
References: <1478623550-18716-1-git-send-email-yousaf.kaukab@suse.com>
	<1478623550-18716-2-git-send-email-yousaf.kaukab@suse.com>
Date: Tue, 8 Nov 2016 22:40:20 -0200
Message-ID: <CAKi4VAKh0R-RN1j=Eum3wKtQ434D_7uBj1EGwzGCBrEB0qFkTg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] depmod: ignore related modules in depmod_report_cycles
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
Cc: linux-modules <linux-modules@vger.kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>, bjorn.andersson@linaro.org, afaerber@suse.de
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Tue, Nov 8, 2016 at 2:45 PM, Mian Yousaf Kaukab
<yousaf.kaukab@suse.com> wrote:
> Only print actual cyclic dependencies. Print count of all the modules
> in cyclic dependency at the end of the function so that dependent
> modules which are not in cyclic chain can be ignored.
>
> Printing dependent modules which are not in cyclic chain causes buffer
> overflow as m->modnamesz is not included in buffer size calculations
> (loop =3D=3D m is never true). This buffer overflow causes kmod to crash.
>
> Update depmod test to reflect the change as well.
>
> Reported-by: Andreas F=C3=A4rber <afaerber@suse.de>
> Signed-off-by: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
> ---
> Change-log:
>  v1: Keep the old output stings. Only change their order
>      Add test case to reproduce the problem
>
>  .../rootfs-pristine/test-depmod/detect-loop/correct.txt     |  2 +-
>  tools/depmod.c                                              | 13 +++++++=
+++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/testsuite/rootfs-pristine/test-depmod/detect-loop/correct.tx=
t b/testsuite/rootfs-pristine/test-depmod/detect-loop/correct.txt
> index 4eb26df..01ecb89 100644
> --- a/testsuite/rootfs-pristine/test-depmod/detect-loop/correct.txt
> +++ b/testsuite/rootfs-pristine/test-depmod/detect-loop/correct.txt
> @@ -1,3 +1,3 @@
> -depmod: ERROR: Found 5 modules in dependency cycles!
>  depmod: ERROR: Cycle detected: mod_loop_d -> mod_loop_e -> mod_loop_d
>  depmod: ERROR: Cycle detected: mod_loop_b -> mod_loop_c -> mod_loop_a ->=
 mod_loop_b
> +depmod: ERROR: Found 5 modules in dependency cycles!
> diff --git a/tools/depmod.c b/tools/depmod.c
> index ad01f66..f2b370f 100644
> --- a/tools/depmod.c
> +++ b/tools/depmod.c
> @@ -1456,7 +1456,7 @@ static void depmod_report_cycles(struct depmod *dep=
mod, uint16_t n_mods,
>  {
>         const char sep[] =3D " -> ";
>         int ir =3D 0;
> -       ERR("Found %u modules in dependency cycles!\n", n_roots);
> +       int num_cyclic =3D 0;
>
>         while (n_roots > 0) {
>                 int is, ie;
> @@ -1491,6 +1491,7 @@ static void depmod_report_cycles(struct depmod *dep=
mod, uint16_t n_mods,
>                         if (m->visited) {
>                                 int i, n =3D 0, sz =3D 0;
>                                 char *buf;
> +                               bool is_cyclic =3D false;
>
>                                 for (i =3D ie - 1; i >=3D 0; i--) {
>                                         struct mod *loop =3D depmod->modu=
les.array[edges[i]];
> @@ -1498,9 +1499,17 @@ static void depmod_report_cycles(struct depmod *de=
pmod, uint16_t n_mods,
>                                         n++;
>                                         if (loop =3D=3D m) {
>                                                 sz +=3D loop->modnamesz -=
 1;
> +                                               is_cyclic =3D true;
>                                                 break;
>                                         }
>                                 }
> +                               /* Current module not found in dependency=
 list.
> +                                * Must be a related module. Ignore it.
> +                                */
> +                               if (!is_cyclic)
> +                                       continue;
> +
> +                               num_cyclic +=3D n;
>
>                                 buf =3D malloc(sz + n * strlen(sep) + 1);
>                                 sz =3D 0;
> @@ -1538,6 +1547,8 @@ static void depmod_report_cycles(struct depmod *dep=
mod, uint16_t n_mods,
>                         }
>                 }
>         }
> +
> +       ERR("Found %d modules in dependency cycles!\n", num_cyclic);
>  }

thanks, much better now.

Applied.

Lucas De Marchi
