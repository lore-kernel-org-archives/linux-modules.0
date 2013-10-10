MIME-Version: 1.0
In-Reply-To: <1381367392-11293-1-git-send-email-sgw@linux.intel.com>
References: <1381367392-11293-1-git-send-email-sgw@linux.intel.com>
Date: Thu, 10 Oct 2013 02:36:36 -0300
Message-ID: <CAKi4VAJJfoWpW7VGachwdbkuonQjKoEGuP4dTT8-5VPkLqv=Fg@mail.gmail.com>
Subject: Re: [PATCH] Makefile.am: Add target to all cross-compilation of testsuite
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Saul Wold <sgw@linux.intel.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Wed, Oct 9, 2013 at 10:09 PM, Saul Wold <sgw@linux.intel.com> wrote:
> The buildtest-TESTS target allows for cross-compilation of the testsuites
> without the actual running of the tests that check normally does.
>
> Signed-off-by: Saul Wold <sgw@linux.intel.com>
> ---
>  Makefile.am | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Makefile.am b/Makefile.am
> index c165868..e22165c 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -217,6 +217,9 @@ DISTCHECK_CONFIGURE_FLAGS=--enable-gtk-doc --sysconfdir=/etc --with-zlib
>
>  distclean-local: $(DISTCLEAN_LOCAL_HOOKS)
>
> +buildtest-TESTS:
> +       $(MAKE) $(AM_MAKEFLAGS) $(check_LTLIBRARIES) $(check_PROGRAMS)
> +
>  # ------------------------------------------------------------------------------
>  # custom release helpers
>  # ------------------------------------------------------------------------------
> --

This patch has been applied. Thanks.


Lucas De Marchi
