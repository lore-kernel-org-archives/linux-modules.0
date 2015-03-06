MIME-Version: 1.0
In-Reply-To: <1425571599-26032-3-git-send-email-caio.oliveira@intel.com>
References: <1425571599-26032-1-git-send-email-caio.oliveira@intel.com>
	<1425571599-26032-3-git-send-email-caio.oliveira@intel.com>
Date: Fri, 6 Mar 2015 00:23:29 -0300
Message-ID: <CAKi4VAKWR=4-dX3u5UciAjLnQYgKdQQ+=MuY44GCC42d+ERm2w@mail.gmail.com>
Subject: Re: [PATCH 3/3] tools: add basic versions of insert and remove
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Overall it's nice, but I have some comments on this one. See below

On Thu, Mar 5, 2015 at 1:06 PM, Caio Marcelo de Oliveira Filho
<caio.oliveira@intel.com> wrote:
> diff --git a/testsuite/test-tools.c b/testsuite/test-tools.c
> new file mode 100644
> index 0000000..66a78a1
> --- /dev/null
> +++ b/testsuite/test-tools.c
> @@ -0,0 +1,54 @@
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <stddef.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +#include "testsuite.h"
> +
> +static noreturn int kmod_tool_insert(const struct test *t)
> +{
> +       const char *progname = ABS_TOP_BUILDDIR "/tools/kmod";
> +       const char *const args[] = {
> +               progname,
> +               "insert", "mod-simple",
> +               NULL,
> +       };
> +
> +       test_spawn_prog(progname, args);
> +       exit(EXIT_FAILURE);
> +}
> +DEFINE_TEST(kmod_tool_insert,
> +       .description = "check kmod insert",
> +       .config = {
> +               [TC_UNAME_R] = "4.4.4",
> +               [TC_ROOTFS] = TESTSUITE_ROOTFS "test-tools/insert",
> +               [TC_INIT_MODULE_RETCODES] = "",

are these and other similar ones  correct? why do you need to set it
to an empty string?


> diff --git a/tools/insert.c b/tools/insert.c
> new file mode 100644
> index 0000000..cc5bbc6
> --- /dev/null
> +++ b/tools/insert.c
> @@ -0,0 +1,126 @@
> +/*
> + * kmod-insert - insert a module into the kernel.
> + *
> + * Copyright (C) 2011-2013  ProFUSION embedded systems

Add a Copyright line here (and in remove.c as well). These are more
than just copies.

> + *
> + * This program is free software: you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation, either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <errno.h>
> +#include <getopt.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#include <libkmod/libkmod.h>
> +
> +#include "kmod.h"
> +
> +static const char cmdopts_s[] = "h";
> +static const struct option cmdopts[] = {
> +       {"help", no_argument, 0, 'h'},
> +       {NULL, 0, 0, 0}

use empty initializers:  { }

> +static int do_insert(int argc, char *argv[])
> +{

[ ... ]

> +       kmod_list_foreach(l, list) {
> +               struct kmod_module *mod = kmod_module_get_module(l);
> +
> +               err = kmod_module_probe_insert_module(mod, KMOD_PROBE_APPLY_BLACKLIST, NULL, NULL, NULL, NULL);
> +               if (err != 0)
> +                       ERR("Could not insert '%s': %s\n", kmod_module_get_name(mod), mod_strerror(err));
> +
> +               kmod_module_unref(mod);

missing 1 unref() in the error path. Just reorder the error check with
the unref() and you'll be fine.

> diff --git a/tools/remove.c b/tools/remove.c
> new file mode 100644
> index 0000000..e3c1550
> --- /dev/null
> +++ b/tools/remove.c
> @@ -0,0 +1,149 @@
> +/*
> + * kmod-rmmod - remove modules from the kernel.

kmod-remove


thanks.

-- 
Lucas De Marchi
