MIME-Version: 1.0
In-Reply-To: <1393541533-14719-2-git-send-email-mmarek@suse.cz>
References: <1393541533-14719-1-git-send-email-mmarek@suse.cz>
	<1393541533-14719-2-git-send-email-mmarek@suse.cz>
Date: Fri, 28 Feb 2014 03:32:40 -0300
Message-ID: <CAKi4VAKOh5n9qWjLj1PpO3c0b1xzQOEMdKuD0Fe=C0a2tHmUAQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] testsuite: Check the list of loaded modules after a test
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Michal Marek <mmarek@suse.cz>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Thu, Feb 27, 2014 at 7:52 PM, Michal Marek <mmarek@suse.cz> wrote:
> Add a ->modules_loaded member to struct test, which is a comma-separated
> list of modules that should be present after the test finishes. Both
> missing and excess modules cause an error.
> ---
>  testsuite/test-init.c     |    1 +
>  testsuite/test-modprobe.c |   13 +++-
>  testsuite/testsuite.c     |  158 ++++++++++++++++++++++++++++++++++++++++++++-
>  testsuite/testsuite.h     |    2 +
>  4 files changed, 168 insertions(+), 6 deletions(-)
>
> diff --git a/testsuite/test-init.c b/testsuite/test-init.c
> index 63b6501..d2aa4bd 100644
> --- a/testsuite/test-init.c
> +++ b/testsuite/test-init.c
> @@ -74,6 +74,7 @@ static DEFINE_TEST(test_insert,
>                 [TC_ROOTFS] = TESTSUITE_ROOTFS "test-init/",
>                 [TC_INIT_MODULE_RETCODES] = "bla:1:20",
>         },
> +       .modules_loaded = "ext4",
>         .need_spawn = true);
>
>  static noreturn int test_remove(const struct test *t)
> diff --git a/testsuite/test-modprobe.c b/testsuite/test-modprobe.c
> index 637d363..c3ef31e 100644
> --- a/testsuite/test-modprobe.c
> +++ b/testsuite/test-modprobe.c
> @@ -91,7 +91,9 @@ static DEFINE_TEST(modprobe_show_alias_to_none,
>         },
>         .output = {
>                 .out = TESTSUITE_ROOTFS "test-modprobe/show-depends/correct-psmouse.txt",
> -       });
> +       },
> +       .modules_loaded = "",
> +       );
>
>
>  static noreturn int modprobe_builtin(const struct test *t)
> @@ -131,7 +133,9 @@ static DEFINE_TEST(modprobe_softdep_loop,
>                 [TC_UNAME_R] = "4.4.4",
>                 [TC_ROOTFS] = TESTSUITE_ROOTFS "test-modprobe/softdep-loop",
>                 [TC_INIT_MODULE_RETCODES] = "",
> -       });
> +       },
> +       .modules_loaded = "btusb,bluetooth",
> +       );
>
>  static noreturn int modprobe_install_cmd_loop(const struct test *t)
>  {
> @@ -156,6 +160,7 @@ static DEFINE_TEST(modprobe_install_cmd_loop,
>                 { "MODPROBE", ABS_TOP_BUILDDIR "/tools/modprobe" },
>                 { }
>                 },
> +       .modules_loaded = "snd,snd-pcm",
>         );
>
>  static noreturn int modprobe_param_kcmdline(const struct test *t)
> @@ -178,7 +183,9 @@ static DEFINE_TEST(modprobe_param_kcmdline,
>         },
>         .output = {
>                 .out = TESTSUITE_ROOTFS "test-modprobe/module-param-kcmdline/correct.txt",
> -       });
> +       },
> +       .modules_loaded = "",
> +       );
>
>
>  static const struct test *tests[] = {
> diff --git a/testsuite/testsuite.c b/testsuite/testsuite.c
> index 9877a64..f0fb393 100644
> --- a/testsuite/testsuite.c
> +++ b/testsuite/testsuite.c
> @@ -20,6 +20,7 @@
>  #include <fcntl.h>
>  #include <getopt.h>
>  #include <limits.h>
> +#include <dirent.h>
>  #include <stdio.h>
>  #include <stdarg.h>
>  #include <stdlib.h>
> @@ -528,12 +529,158 @@ fail:
>         return true;
>  }
>
> +static int cmp_modnames(const void *m1, const void *m2)
> +{
> +       const char *s1 = *(char * const *)m1;
> +       const char *s2 = *(char * const *)m2;
> +       int i;
> +
> +       for (i = 0;; i++) {
> +               char c1 = s1[i], c2 = s2[i];
> +               if (c1 == ',')
> +                       c1 = '\0';
> +               if (c1 == '-')
> +                       c1 = '_';
> +               if (c2 == ',')
> +                       c2 = '\0';
> +               if (c2 == '-')
> +                       c2 = '_';
> +
> +               if (c1 == '\0' && c2 == '\0')
> +                       return 0;
> +               if (c1 != c2)
> +                       return c1 - c2;
> +       }
> +}
> +
> +static const char ** read_expected_modules(const struct test *t, int * count)

There's one extra space there... It'd the first time " ** " and " * "
would appear in the codebase.

The rest of the review is more about doing less allocations, but since
this is in the testsuite, I'm willing to apply as is if you prefer.

> +{
> +       const char **res;
> +       int len;
> +       int i;
> +       const char *p;
> +
> +       /*
> +        * Store pointers to elements of t->modules_loaded into res
> +        * (comma is considered equivalent to NUL)
> +        */
> +       if (t->modules_loaded[0] == '\0') {
> +               *count = 0;
> +               return NULL;
> +       }
> +       len = 1;
> +       for (p = t->modules_loaded; *p; p++)
> +               if (*p == ',')
> +                       len++;
> +       res = malloc(sizeof(char *) * len);
> +       if (!res) {
> +               perror("malloc");
> +               *count = -1;
> +               return NULL;
> +       }
> +       i = 0;
> +       res[i] = t->modules_loaded;
> +       for (p = t->modules_loaded; *p; p++)
> +               if (*p == ',')
> +                       res[++i] = p + 1;
> +       *count = len;
> +       return res;
> +}
> +
> +static char ** read_loaded_modules(const struct test *t, int * count)
> +{
> +       char *dirname;
> +       DIR *dir;
> +       struct dirent *dirent;
> +       int i;
> +       int len = 0;
> +       char **res = NULL;
> +
> +       /* Store the entries in /sys/module to res */
> +       dirname = malloc(PATH_MAX + 1);
> +       if (!dirname) {
> +               perror("malloc");
> +               *count = -1;
> +               return res;
> +       }

you can do this on stack like we do everywhere else for non-recursive functions.

> +       snprintf(dirname, PATH_MAX, "%s/sys/module",
> +                       t->config[TC_ROOTFS] ? t->config[TC_ROOTFS] : "");
> +       dir = opendir(dirname);
> +       /* not an error, simply return empty list */
> +       if (!dir)
> +               goto out_dirname;
> +       while ((dirent = readdir(dir))) {
> +               if (dirent->d_name[0] == '.')
> +                       continue;
> +               len++;
> +       }
> +       res = malloc(sizeof(char *) * len);
> +       if (!res) {
> +               perror("malloc");
> +               len = -1;
> +               goto out_dir;
> +       }
> +       rewinddir(dir);
> +       i = 0;
> +       while ((dirent = readdir(dir))) {
> +               if (dirent->d_name[0] == '.')
> +                       continue;
> +               res[i] = strdup(dirent->d_name);
> +               if (!res[i]) {
> +                       for (i--; i >= 0; i--)
> +                               free(res[i]);
> +                       free(res);
> +                       res = NULL;
> +                       len = -1;
> +                       goto out_dir;
> +               }

In the first loop you could store the total size and then allocate
only one big string. Then in the second loop you just copy d_name to
the buffer. Just make sure not to extrapolate the size allocated in
the previous loop. Then you don't need all the "free in loop code
above and below.

> +               i++;
> +       }
> +out_dir:
> +       closedir(dir);
> +out_dirname:
> +       free(dirname);
> +       *count = len;
> +       return res;
> +}
> +
> +static int check_loaded_modules(const struct test *t)
> +{
> +       int l1, l2, i;
> +       const char **a1;
> +       char **a2;
> +       int err = false;
> +
> +       a1 = read_expected_modules(t, &l1);
> +       if (l1 < 0)
> +               return err;
> +       a2 = read_loaded_modules(t, &l2);
> +       if (l2 < 0)
> +               goto out_a1;
> +       /* TODO: Report which modules are missing/superfluous */
> +       if (l1 != l2)
> +               goto out_a2;
> +       qsort(a1, l1, sizeof(char *), cmp_modnames);
> +       qsort(a2, l2, sizeof(char *), cmp_modnames);
> +       for (i = 0; i < l1; i++)
> +               if (cmp_modnames(&a1[i], &a2[i]) != 0)
> +                       goto out_a2;

Isn't the order important? If we take the order into account the code
could be even simpler because we don't even have to store the char **.
Just build the second string with ',' as separator and strcmp() them.


Lucas De Marchi
