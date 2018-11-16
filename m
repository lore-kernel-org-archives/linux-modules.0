Return-Path: <SRS0=g1YY=N3=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F6AC43441
	for <linux-modules@archiver.kernel.org>; Fri, 16 Nov 2018 00:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84610208A3
	for <linux-modules@archiver.kernel.org>; Fri, 16 Nov 2018 00:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84610208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeKPKRx (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:17:53 -0500
Received: from mga06.intel.com ([134.134.136.31]:56337 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbeKPKRx (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 16 Nov 2018 05:17:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2018 16:07:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,238,1539673200"; 
   d="scan'208";a="89700168"
Received: from ldmartin-desk.jf.intel.com ([10.24.8.243])
  by orsmga007.jf.intel.com with ESMTP; 15 Nov 2018 16:07:49 -0800
Subject: Re: [PATCH] signature: do not report wrong data for pkc#7 signature
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        linux-modules@vger.kernel.org
Cc:     ykaliuta@redhat.com
References: <20181115212945.24690-1-yauheni.kaliuta@redhat.com>
From:   Lucas De Marchi <lucas.demarchi@intel.com>
Message-ID: <c5ee17b5-d3cf-9b88-5dd4-96f695ffdadd@intel.com>
Date:   Thu, 15 Nov 2018 16:07:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181115212945.24690-1-yauheni.kaliuta@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On 11/15/18 1:29 PM, Yauheni Kaliuta wrote:
> when PKC#7 signing method is used the old structure doesn't contain
> any useful data, but the data are encoded in the certificate.
> 
> The info getting/showing code is not aware of that at the moment and
> since 0 is a valid constant, shows, for example, wrong "md4" for the
> hash algo.
> 
> The patch splits the 2 mothods of gethering the info and reports
> "unknown" for the algo.
> 
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
>   libkmod/libkmod-module.c    |  2 +-
>   libkmod/libkmod-signature.c | 69 +++++++++++++++++++++++++++----------
>   2 files changed, 52 insertions(+), 19 deletions(-)
> 
> diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
> index ee420f4ec2bf..889f26479a98 100644
> --- a/libkmod/libkmod-module.c
> +++ b/libkmod/libkmod-module.c
> @@ -2273,7 +2273,7 @@ KMOD_EXPORT int kmod_module_get_info(const struct kmod_module *mod, struct kmod_
>   	struct kmod_elf *elf;
>   	char **strings;
>   	int i, count, ret = -ENOMEM;
> -	struct kmod_signature_info sig_info;
> +	struct kmod_signature_info sig_info = {};
>   
>   	if (mod == NULL || list == NULL)
>   		return -ENOENT;
> diff --git a/libkmod/libkmod-signature.c b/libkmod/libkmod-signature.c
> index 1f3e26dea203..2ec2dc1a1a73 100644
> --- a/libkmod/libkmod-signature.c
> +++ b/libkmod/libkmod-signature.c
> @@ -92,6 +92,44 @@ struct module_signature {
>   	uint32_t sig_len;    /* Length of signature data (big endian) */
>   };
>   
> +static bool
> +kmod_module_signature_info_default(const char *mem,
> +				   off_t size,
> +				   const struct module_signature *modsig,
> +				   size_t sig_len,
> +				   struct kmod_signature_info *sig_info)
> +{
> +	size -= sig_len;
> +	sig_info->sig = mem + size;
> +	sig_info->sig_len = sig_len;
> +
> +	size -= modsig->key_id_len;
> +	sig_info->key_id = mem + size;
> +	sig_info->key_id_len = modsig->key_id_len;
> +
> +	size -= modsig->signer_len;
> +	sig_info->signer = mem + size;
> +	sig_info->signer_len = modsig->signer_len;
> +
> +	sig_info->algo = pkey_algo[modsig->algo];
> +	sig_info->hash_algo = pkey_hash_algo[modsig->hash];
> +	sig_info->id_type = pkey_id_type[modsig->id_type];
> +
> +	return true;
> +}
> +
> +static bool
> +kmod_module_signature_info_pkcs7(const char *mem,

I miss a verb in these function names. Those seem more reasonable:

static bool fill_default() { }
static bool fill_unknown() { }


Otherwise looks good.

thanks
Lucas De Marchi

> +				 off_t size,
> +				 const struct module_signature *modsig,
> +				 size_t sig_len,
> +				 struct kmod_signature_info *sig_info)
> +{
> +	sig_info->hash_algo = "unknown";
> +	sig_info->id_type = pkey_id_type[modsig->id_type];
> +	return true;
> +}
> +
>   #define SIG_MAGIC "~Module signature appended~\n"
>   
>   /*
> @@ -111,7 +149,7 @@ bool kmod_module_signature_info(const struct kmod_file *file, struct kmod_signat
>   	off_t size;
>   	const struct module_signature *modsig;
>   	size_t sig_len;
> -
> +	bool ret;
>   
>   	size = kmod_file_get_size(file);
>   	mem = kmod_file_get_contents(file);
> @@ -134,21 +172,16 @@ bool kmod_module_signature_info(const struct kmod_file *file, struct kmod_signat
>   	    size < (int64_t)(modsig->signer_len + modsig->key_id_len + sig_len))
>   		return false;
>   
> -	size -= sig_len;
> -	sig_info->sig = mem + size;
> -	sig_info->sig_len = sig_len;
> -
> -	size -= modsig->key_id_len;
> -	sig_info->key_id = mem + size;
> -	sig_info->key_id_len = modsig->key_id_len;
> -
> -	size -= modsig->signer_len;
> -	sig_info->signer = mem + size;
> -	sig_info->signer_len = modsig->signer_len;
> -
> -	sig_info->algo = pkey_algo[modsig->algo];
> -	sig_info->hash_algo = pkey_hash_algo[modsig->hash];
> -	sig_info->id_type = pkey_id_type[modsig->id_type];
> -
> -	return true;
> +	switch (modsig->id_type) {
> +	case PKEY_ID_PKCS7:
> +		ret = kmod_module_signature_info_pkcs7(mem, size,
> +						       modsig, sig_len,
> +						       sig_info);
> +		break;
> +	default:
> +		ret = kmod_module_signature_info_default(mem, size,
> +							 modsig, sig_len,
> +							 sig_info);
> +	}
> +	return ret;
>   }
> 
