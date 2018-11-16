Return-Path: <SRS0=g1YY=N3=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA8CC43441
	for <linux-modules@archiver.kernel.org>; Fri, 16 Nov 2018 09:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E0D208A3
	for <linux-modules@archiver.kernel.org>; Fri, 16 Nov 2018 09:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E0D208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-modules-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeKPTNM (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:13:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:34864 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbeKPTNM (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 16 Nov 2018 14:13:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 01:01:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,239,1539673200"; 
   d="scan'208";a="105093573"
Received: from anaghami-mobl.amr.corp.intel.com (HELO ldmartin-desk.jf.intel.com) ([10.255.228.156])
  by fmsmga002.fm.intel.com with ESMTP; 16 Nov 2018 01:01:47 -0800
Subject: Re: [PATCH v2] signature: do not report wrong data for pkc#7
 signature
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        linux-modules@vger.kernel.org
Cc:     ykaliuta@redhat.com
References: <20181116085634.4673-1-yauheni.kaliuta@redhat.com>
From:   Lucas De Marchi <lucas.demarchi@intel.com>
Message-ID: <83bd29de-9318-1ecc-2640-788cfe52174b@intel.com>
Date:   Fri, 16 Nov 2018 01:01:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181116085634.4673-1-yauheni.kaliuta@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>



On 11/16/18 12:56 AM, Yauheni Kaliuta wrote:
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
>   libkmod/libkmod-signature.c | 59 ++++++++++++++++++++++++++-----------
>   2 files changed, 42 insertions(+), 19 deletions(-)
> ---
> 
> Changelog:
> 
> v1 -> v2:
> 
> changed helper names to verb form.
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
> index 1f3e26dea203..13c426ace901 100644
> --- a/libkmod/libkmod-signature.c
> +++ b/libkmod/libkmod-signature.c
> @@ -92,6 +92,38 @@ struct module_signature {
>   	uint32_t sig_len;    /* Length of signature data (big endian) */
>   };
>   
> +static bool fill_default(const char *mem, off_t size,
> +			 const struct module_signature *modsig, size_t sig_len,
> +			 struct kmod_signature_info *sig_info)
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
> +static bool fill_unknown(const char *mem, off_t size,
> +			 const struct module_signature *modsig, size_t sig_len,
> +			 struct kmod_signature_info *sig_info)
> +{
> +	sig_info->hash_algo = "unknown";
> +	sig_info->id_type = pkey_id_type[modsig->id_type];
> +	return true;
> +}
> +
>   #define SIG_MAGIC "~Module signature appended~\n"
>   
>   /*
> @@ -111,7 +143,7 @@ bool kmod_module_signature_info(const struct kmod_file *file, struct kmod_signat
>   	off_t size;
>   	const struct module_signature *modsig;
>   	size_t sig_len;
> -
> +	bool ret;
>   
>   	size = kmod_file_get_size(file);
>   	mem = kmod_file_get_contents(file);
> @@ -134,21 +166,12 @@ bool kmod_module_signature_info(const struct kmod_file *file, struct kmod_signat
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
> +		ret = fill_unknown(mem, size, modsig, sig_len, sig_info);
> +		break;
> +	default:
> +		ret = fill_default(mem, size, modsig, sig_len, sig_info);
> +	}

I squashed the patch to remove "ret" and just returning inside the switch.

Applied, thanks.

Lucas De Marchi

> +	return ret;
>   }
> 
