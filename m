MIME-Version: 1.0
Date: Mon, 11 Jun 2018 10:12:10 -0700
References: <xunyy3iw47ih.fsf@redhat.com>
	<20180608171015.2211-1-msuchanek@suse.de>
In-Reply-To: <20180608171015.2211-1-msuchanek@suse.de>
Message-ID: <CAKi4VA+=Twgsz_6vEyuGx=pqYBqpZO0fcqWrukqtMc7R-9EtiA@mail.gmail.com>
Subject: Re: [PATCH] libkmod-signature: pkcs#7: fix crash when signer info is
 not present.
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Michal Suchanek <msuchanek@suse.de>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
	linux-modules <linux-modules@vger.kernel.org>, Ferry van Steen <Ferry.van.Steen@citrus.nl>,
	David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-modules.vger.kernel.org>

On Fri, Jun 8, 2018 at 10:10 AM Michal Suchanek <msuchanek@suse.de> wrote:
>
> Reported-by: Kazuya Saito <saito.kazuya@jp.fujitsu.com>
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  libkmod/libkmod-signature.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
> index fae074e6dd1d..782e96f69fef 100644
> --- a/libkmod/libkmod-signature.c
> +++ b/libkmod/libkmod-signature.c
> @@ -166,7 +166,7 @@ kmod_module_signature_info_pkcs7(const char *mem,

What's this based on? There's no such function in upstream


Lucas De Marchi

>         sig_info->key_id_len = cert->key_id_size;
>
>         sig_info->signer = cert->signer;
> -       sig_info->signer_len = strlen(cert->signer);
> +       sig_info->signer_len = cert->signer ? strlen(cert->signer) : 0;
>
>         sig_info->algo = NULL;
>         sig_info->hash_algo = cert->hash_algo;
> --
> 2.13.6
>


-- 
Lucas De Marchi
