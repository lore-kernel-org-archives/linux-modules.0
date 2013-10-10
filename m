MIME-Version: 1.0
In-Reply-To: <1381387788-5058-1-git-send-email-sgw@linux.intel.com>
References: <1381387788-5058-1-git-send-email-sgw@linux.intel.com>
Date: Thu, 10 Oct 2013 11:23:53 -0300
Message-ID: <CAKi4VAJLzv2sxYukxCfscE=4u0Dg8uDiVUg3R+XJf19QWmaTag@mail.gmail.com>
Subject: Re: [PATCH] Makefile.am: add mkdir testsuite
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Saul Wold <sgw@linux.intel.com>
Cc: linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

On Thu, Oct 10, 2013 at 3:49 AM, Saul Wold <sgw@linux.intel.com> wrote:
> If we are note building in the existing source tree and have disabled
> dependency-tracking then the testsuite directory is not created during
> the configure phase and will not exist when the cp of ROOTFS_PRISTINE
> occurs, thus causing an error and fail.
>
> Signed-off-by: Saul Wold <sgw@linux.intel.com>
> ---
>  Makefile.am | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile.am b/Makefile.am
> index 91a766a..4ff42ae 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -130,7 +130,7 @@ endif
>
>  ROOTFS = testsuite/rootfs
>  ROOTFS_PRISTINE = $(top_srcdir)/testsuite/rootfs-pristine
> -CREATE_ROOTFS = $(AM_V_GEN) ( $(RM) -rf $(ROOTFS) && \
> +CREATE_ROOTFS = $(AM_V_GEN) ( $(RM) -rf $(ROOTFS) && mkdir -p $(dir $(ROOTFS)) && \
>                                 cp -r $(ROOTFS_PRISTINE) $(ROOTFS) && \
>                                 touch testsuite/stamp-rootfs && \
>                                 find $(ROOTFS) -type d -exec chmod +w {} \; )

Patch has been applied

Thanks
Lucas De Marchi
