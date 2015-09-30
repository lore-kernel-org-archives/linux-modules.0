MIME-Version: 1.0
In-Reply-To: <1443479954-31484-1-git-send-email-labbott@fedoraproject.org>
References: <1443479954-31484-1-git-send-email-labbott@fedoraproject.org>
Date: Wed, 30 Sep 2015 15:30:26 -0300
Message-ID: <CAKi4VA+bQTH=gv3bA3VU-iDNL1ae37qBQDocCoT5SV_CR4KHYQ@mail.gmail.com>
Subject: Re: [PATCHv2 1/5] README: Indicate cython requirements
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Laura Abbott <labbott@fedoraproject.org>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-modules.vger.kernel.org>

Hi Laura,

thank you for the patches, they are all applied.


Lucas De Marchi

On Mon, Sep 28, 2015 at 7:39 PM, Laura Abbott <labbott@fedoraproject.org> wrote:
>
> The recommended flags require cython be installed to compile
> successfully. Note this in the documentation.
> ---
>  README | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/README b/README
> index b977e1f..4933268 100644
> --- a/README
> +++ b/README
> @@ -63,7 +63,8 @@ Hacking
>  =======
>
>  Run 'bootstrap' script before configure. If you want to accept the recommended
> -flags, you just need to run 'bootstrap-configure'.
> +flags, you just need to run 'bootstrap-configure'. Note that the recommended
> +flags require cython be installed to compile successfully.
>
>  Make sure to read the CODING-STYLE file and the other READMEs: libkmod/README
>  and testsuite/README.
> --
> 2.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-modules" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Lucas De Marchi
