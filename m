Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: Michal Suchanek <msuchanek@suse.de>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,  linux-modules <linux-modules@vger.kernel.org>,  Ferry van Steen <Ferry.van.Steen@citrus.nl>,  David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] libkmod-signature: Fix crash when module signature is not present.
References: <20180308135810.4309-2-yauheni.kaliuta@redhat.com>
	<20180308181426.5617-1-msuchanek@suse.de>
Date: Mon, 12 Mar 2018 22:41:19 +0200
In-Reply-To: <20180308181426.5617-1-msuchanek@suse.de> (Michal Suchanek's
	message of "Thu, 8 Mar 2018 19:14:26 +0100")
Message-ID: <xunyzi3d9gcw.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-modules.vger.kernel.org>

Hi, Michal!

>>>>> On Thu,  8 Mar 2018 19:14:26 +0100, Michal Suchanek  wrote:

 > The mod_sig is allocated on stack and when no signature is present it is not
 > initialized and contains garbage. Later when freeing mod_sig garbage pointer is
 > dereferenced.

I guess, it is enough to init the structure.

 > Make mod_sig pointer initialized to NULL instead so it has meaningful value
 > only when a signature was stored in it. This somewhat straightens the interface
 > to kmod_module_signature_info as well.

 > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
 > ---
 >  libkmod/libkmod-internal.h  |  2 +-
 >  libkmod/libkmod-module.c    | 21 +++++++++---------
 >  libkmod/libkmod-signature.c | 53 +++++++++++++++++++++++++--------------------
 >  3 files changed, 42 insertions(+), 34 deletions(-)

 > diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
 > index 2ad74c7a33a5..8bc9ecfb906e 100644
 > --- a/libkmod/libkmod-internal.h
 > +++ b/libkmod/libkmod-internal.h
 > @@ -192,5 +192,5 @@ struct kmod_signature_info {
 >  	void (*free)(void *);
 >  	void *private;
 >  };
 > -bool kmod_module_signature_info(const struct kmod_file *file, struct kmod_signature_info *sig_info) _must_check_ __attribute__((nonnull(1, 2)));
 > +struct kmod_signature_info *kmod_module_signature_info(const struct kmod_file *file) _must_check_ __attribute__((nonnull(1)));
 >  void kmod_module_signature_info_free(struct kmod_signature_info *sig_info) __attribute__((nonnull));
 > diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
 > index 7b00d526edec..cbe35819932e 100644
 > --- a/libkmod/libkmod-module.c
 > +++ b/libkmod/libkmod-module.c
 > @@ -2304,7 +2304,7 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
 >  	struct kmod_elf *elf;
 >  	char **strings;
 >  	int i, count, ret = -ENOMEM;
 > -	struct kmod_signature_info sig_info;
 > +	struct kmod_signature_info *sig_info = NULL;
 
 >  	if (mod == NULL || list == NULL)
 >  		return -ENOENT;
 > @@ -2341,32 +2341,32 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
 >  			goto list_error;
 >  	}
 
 > -	if (kmod_module_signature_info(mod->file, &sig_info)) {
 > +	if (sig_info = kmod_module_signature_info(mod->file)) {
 >  		struct kmod_list *n;
 
 >  		n = kmod_module_info_append(list, "sig_id", strlen("sig_id"),
 > -				sig_info.id_type, strlen(sig_info.id_type));
 > +				sig_info->id_type, strlen(sig_info->id_type));
 >  		if (n == NULL)
 >  			goto list_error;
 >  		count++;
 
 >  		n = kmod_module_info_append(list, "signer", strlen("signer"),
 > -				sig_info.signer, sig_info.signer_len);
 > +				sig_info->signer, sig_info->signer_len);
 >  		if (n == NULL)
 >  			goto list_error;
 >  		count++;
 
 
 >  		n = kmod_module_info_append_hex(list, "sig_key", strlen("sig_key"),
 > -						sig_info.key_id,
 > -						sig_info.key_id_len);
 > +						sig_info->key_id,
 > +						sig_info->key_id_len);
 >  		if (n == NULL)
 >  			goto list_error;
 >  		count++;
 
 >  		n = kmod_module_info_append(list,
 >  				"sig_hashalgo", strlen("sig_hashalgo"),
 > -				sig_info.hash_algo, strlen(sig_info.hash_algo));
 > +				sig_info->hash_algo, strlen(sig_info->hash_algo));
 >  		if (n == NULL)
 >  			goto list_error;
 >  		count++;
 > @@ -2377,8 +2377,8 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
 >  		 */
 >  		n = kmod_module_info_append_hex(list, "signature",
 >  						strlen("signature"),
 > -						sig_info.sig,
 > -						sig_info.sig_len);
 > +						sig_info->sig,
 > +						sig_info->sig_len);
 
 >  		if (n == NULL)
 >  			goto list_error;
 > @@ -2389,7 +2389,8 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
 
 >  list_error:
 >  	/* aux structures freed in normal case also */
 > -	kmod_module_signature_info_free(&sig_info);
 > +	if (sig_info)
 > +		kmod_module_signature_info_free(sig_info);
 
 >  	if (ret < 0) {
 >  		kmod_module_info_free_list(*list);
 > diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
 > index bdf84cb14718..fae074e6dd1d 100644
 > --- a/libkmod/libkmod-signature.c
 > +++ b/libkmod/libkmod-signature.c
 > @@ -93,13 +93,17 @@ struct module_signature {
 >  	uint32_t sig_len;    /* Length of signature data (big endian) */
 >  };
 
 > -static bool
 > +static struct kmod_signature_info *
 >  kmod_module_signature_info_default(const char *mem,
 >  				   off_t size,
 >  				   const struct module_signature *modsig,
 > -				   size_t sig_len,
 > -				   struct kmod_signature_info *sig_info)
 > +				   size_t sig_len)
 >  {
 > +	struct kmod_signature_info *sig_info = malloc(sizeof *sig_info);
 > +
 > +	if (!sig_info)
 > +		return NULL;
 > +
 >  	size -= sig_len;
 sig_info-> sig = mem + size;
 sig_info-> sig_len = sig_len;
 > @@ -119,7 +123,7 @@ kmod_module_signature_info_default(const char *mem,
 sig_info-> free = NULL;
 sig_info-> private = NULL;
 
 > -	return true;
 > +	return sig_info;
 >  }
 
 >  static void kmod_module_signature_info_pkcs7_free(void *s)
 > @@ -129,13 +133,13 @@ static void kmod_module_signature_info_pkcs7_free(void *s)
 >  	pkcs7_free_cert(si->private);
 >  }
 
 > -static bool
 > +static struct kmod_signature_info *
 >  kmod_module_signature_info_pkcs7(const char *mem,
 >  				 off_t size,
 >  				 const struct module_signature *modsig,
 > -				 size_t sig_len,
 > -				 struct kmod_signature_info *sig_info)
 > +				 size_t sig_len)
 >  {
 > +	struct kmod_signature_info *sig_info = NULL;
 >  	const char *pkcs7_raw;
 >  	struct pkcs7_cert *cert;
 
 > @@ -144,7 +148,13 @@ kmod_module_signature_info_pkcs7(const char *mem,
 
 >  	cert = pkcs7_parse_cert(pkcs7_raw, sig_len);
 >  	if (cert == NULL)
 > -		return false;
 > +		return NULL;
 > +
 > +	sig_info = malloc(sizeof *sig_info);
 > +	if (!sig_info) {
 > +		free(cert);
 > +		return NULL;
 > +	}
 
 sig_info-> private = cert;
 sig_info-> free = kmod_module_signature_info_pkcs7_free;
 > @@ -162,7 +172,7 @@ kmod_module_signature_info_pkcs7(const char *mem,
 sig_info-> hash_algo = cert->hash_algo;
 sig_info-> id_type = pkey_id_type[modsig->id_type];
 
 > -	return true;
 > +	return sig_info;
 >  }
 
 >  #define SIG_MAGIC "~Module signature appended~\n"
 > @@ -178,48 +188,45 @@ kmod_module_signature_info_pkcs7(const char *mem,
 >   * [ SIG_MAGIC               ]
 >   */
 
 > -bool kmod_module_signature_info(const struct kmod_file *file, struct kmod_signature_info *sig_info)
 > +struct kmod_signature_info *kmod_module_signature_info(const struct kmod_file *file)
 >  {
 >  	const char *mem;
 >  	off_t size;
 >  	const struct module_signature *modsig;
 >  	size_t sig_len;
 > -	bool ret;
 
 >  	size = kmod_file_get_size(file);
 >  	mem = kmod_file_get_contents(file);
 >  	if (size < (off_t)strlen(SIG_MAGIC))
 > -		return false;
 > +		return NULL;
 >  	size -= strlen(SIG_MAGIC);
 >  	if (memcmp(SIG_MAGIC, mem + size, strlen(SIG_MAGIC)) != 0)
 > -		return false;
 > +		return NULL;
 
 >  	if (size < (off_t)sizeof(struct module_signature))
 > -		return false;
 > +		return NULL;
 >  	size -= sizeof(struct module_signature);
 >  	modsig = (struct module_signature *)(mem + size);
 >  	if (modsig->algo >= PKEY_ALGO__LAST ||
 modsig-> hash >= PKEY_HASH__LAST ||
 modsig-> id_type >= PKEY_ID_TYPE__LAST)
 > -		return false;
 > +		return NULL;
 >  	sig_len = be32toh(get_unaligned(&modsig->sig_len));
 >  	if (sig_len == 0 ||
 >  	    size < (int64_t)(modsig->signer_len + modsig->key_id_len + sig_len))
 > -		return false;
 > +		return NULL;
 
 >  	if (modsig->id_type == PKEY_ID_PKCS7)
 > -		ret = kmod_module_signature_info_pkcs7(mem, size,
 > -						       modsig, sig_len,
 > -						       sig_info);
 > +		return kmod_module_signature_info_pkcs7(mem, size,
 > +						        modsig, sig_len);
 >  	else
 > -		ret = kmod_module_signature_info_default(mem, size,
 > -							 modsig, sig_len,
 > -							 sig_info);
 > -	return ret;
 > +		return kmod_module_signature_info_default(mem, size,
 > +							  modsig, sig_len);
 >  }
 
 >  void kmod_module_signature_info_free(struct kmod_signature_info *sig_info)
 >  {
 >  	if (sig_info->free)
 sig_info-> free(sig_info);
 > +	free(sig_info);
 >  }
 > -- 
 > 2.13.6

 > --
 > To unsubscribe from this list: send the line "unsubscribe linux-modules" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
WBR,
Yauheni Kaliuta
