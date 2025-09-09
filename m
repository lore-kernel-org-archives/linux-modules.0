Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFD623A9AD;
	Tue,  9 Sep 2025 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411437; cv=none; b=HTWgQuh1PX6oNg4sO6PvTOrKR28gesA54Xp9pfTplxe5ULii+ebNAr/LutP65hxLe729OsGOXXQnyPFi+LV/zQDLmLGf7CkXN+kSwpwrOMlYg+0v0v2DrMl0LVgphs27/y8T6yXrVoDm6e4hWj8nvV18/DCBQ2KDQ62HRM3ImgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411437; c=relaxed/simple;
	bh=uhxDWoptz2tBQK8hRc6j5prsq9hJfPj6Phx7JbtSAtk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fB6IjNvTA2o715hGvqCOrridAyULOrUA3XWBjrcIqqc4LTjtXYO/RS1jkNBa2ffdej/qn3qcOfnLKWCLb/zBTKSzs48iQYmwSXrKP2h6tMqURdX7NomI9EhOqX8MMXTZAkV9ucxcNImfYp4fqZi9Lw6WqsrgWOdY9d8FZVI3Rms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub4.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4cLdrr57Bjz9sRk;
	Tue,  9 Sep 2025 11:32:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C1oNj3b0ppI5; Tue,  9 Sep 2025 11:32:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4cLdrr357Yz9sRh;
	Tue,  9 Sep 2025 11:32:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 44FAE8B766;
	Tue,  9 Sep 2025 11:32:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 6TTgvUgJ3s7h; Tue,  9 Sep 2025 11:32:28 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F1ACD8B764;
	Tue,  9 Sep 2025 11:32:27 +0200 (CEST)
Message-ID: <d46498e5-db21-4a79-93b4-3869be3660d2@csgroup.eu>
Date: Tue, 9 Sep 2025 11:32:27 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] module : fix signature checker pointer arithmetic and
 bounds check
To: Fidal Palamparambil <rootuserhere@gmail.com>,
 linux-modules@vger.kernel.org
Cc: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
 samitolvanen@google.com, linux-kernel@vger.kernel.org
References: <20250905154550.130-1-rootuserhere@gmail.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250905154550.130-1-rootuserhere@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 05/09/2025 à 17:45, Fidal Palamparambil a écrit :
> From: Fidal palamparambil <rootuserhere@gmail.com>
> 
> This patch fixes :
>   - invalid module_param type (bool_enable_only → bool)

Can you explain what the problem is ? Why do you say bool_enable_only is 
invalid ? Was generalised by commit d19f05d8a8fa ("kernel/params.c: 
generalize bool_enable_only")

>   - unsafe pointer arithmetic on void *

Why is it unsafe in Linux Kernel ? See https://lkml.org/lkml/2022/2/24/978

>   - missing bounds check for sig_len, preventing underflow/OOB

This is checked by mod_check_sig(), why check it again ?

>   - export set_module_sig_enforced for consistency

Consistency with what ? Can you tell which module needs it ?

> 
> Signed-off-by : Fidal Palamparambil <rootuserhere@gmail.com>
> Signed-off-by: Fidal palamparambil <rootuserhere@gmail.com>

Why a double sob ?

> ---
>   kernel/module/signing.c    |  48 ++++++++------
>   kernel/module/signing.orig | 125 +++++++++++++++++++++++++++++++++++++

Why adding this .orig file into the kernel at all ?

>   2 files changed, 155 insertions(+), 18 deletions(-)
>   create mode 100644 kernel/module/signing.orig
> 
> diff --git a/kernel/module/signing.c b/kernel/module/signing.c
> index a2ff4242e623..8dda6cd2fd73 100644
> --- a/kernel/module/signing.c
> +++ b/kernel/module/signing.c
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-or-later
> -/* Module signature checker
> +/*
> + * Module signature checker

Don't mix cosmetic changes and real changes, you are making 
bisectability more difficult.

>    *
>    * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
>    * Written by David Howells (dhowells@redhat.com)
> @@ -20,11 +21,11 @@
>   #define MODULE_PARAM_PREFIX "module."
> 
>   static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
> -module_param(sig_enforce, bool_enable_only, 0644);
> +module_param(sig_enforce, bool, 0644);
> 
>   /*
> - * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
> - * on that instead of directly to CONFIG_MODULE_SIG_FORCE config.
> + * Export sig_enforce kernel cmdline parameter to allow other subsystems to
> + * rely on that instead of directly on CONFIG_MODULE_SIG_FORCE config.
>    */
>   bool is_module_sig_enforced(void)
>   {
> @@ -36,6 +37,7 @@ void set_module_sig_enforced(void)
>   {
>          sig_enforce = true;
>   }
> +EXPORT_SYMBOL(set_module_sig_enforced);
> 
>   /*
>    * Verify the signature on a module.
> @@ -45,44 +47,55 @@ int mod_verify_sig(const void *mod, struct load_info *info)
>          struct module_signature ms;
>          size_t sig_len, modlen = info->len;
>          int ret;
> +       const unsigned char *data = mod;

Pointless change.

> 
>          pr_devel("==>%s(,%zu)\n", __func__, modlen);
> 
>          if (modlen <= sizeof(ms))
>                  return -EBADMSG;
> 
> -       memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
> +       memcpy(&ms, data + (modlen - sizeof(ms)), sizeof(ms));

Pointless change

> 
>          ret = mod_check_sig(&ms, modlen, "module");
>          if (ret)
>                  return ret;
> 
>          sig_len = be32_to_cpu(ms.sig_len);
> +
> +       /* Ensure sig_len is valid to prevent underflow/oob */
> +       if (sig_len > modlen - sizeof(ms))
> +               return -EBADMSG;

Already verified by mod_check_sig()

> +
>          modlen -= sig_len + sizeof(ms);
>          info->len = modlen;
> 
> -       return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
> +       return verify_pkcs7_signature(data, modlen, data + modlen, sig_len,

pointless change

>                                        VERIFY_USE_SECONDARY_KEYRING,
>                                        VERIFYING_MODULE_SIGNATURE,
>                                        NULL, NULL);
>   }
> 
> +/*
> + * Check signature validity of a module during load.
> + */
>   int module_sig_check(struct load_info *info, int flags)
>   {
>          int err = -ENODATA;
>          const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
>          const char *reason;
> -       const void *mod = info->hdr;
> +       const unsigned char *mod = info->hdr;

info->hdr is not void*, how can this work without a cast ?

>          bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
>                                         MODULE_INIT_IGNORE_VERMAGIC);
> +

Unrelated cosmetic change

>          /*
> -        * Do not allow mangled modules as a module with version information
> -        * removed is no longer the module that was signed.
> +        * Do not allow mangled modules: a module with version info removed
> +        * is no longer the module that was signed.
>           */
>          if (!mangled_module &&
>              info->len > markerlen &&
> -           memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
> -               /* We truncate the module to discard the signature */
> +           memcmp(mod + info->len - markerlen,
> +                  MODULE_SIG_STRING, markerlen) == 0) {
> +               /* Truncate the module to discard the signature marker */

Cosmetic and pointless change.

>                  info->len -= markerlen;
>                  err = mod_verify_sig(mod, info);
>                  if (!err) {
> @@ -92,9 +105,8 @@ int module_sig_check(struct load_info *info, int flags)
>          }
> 
>          /*
> -        * We don't permit modules to be loaded into the trusted kernels
> -        * without a valid signature on them, but if we're not enforcing,
> -        * certain errors are non-fatal.
> +        * Enforced mode: only allow modules with a valid signature.
> +        * Non-enforced mode: certain errors are downgraded to warnings.
>           */
>          switch (err) {
>          case -ENODATA:
> @@ -106,12 +118,12 @@ int module_sig_check(struct load_info *info, int flags)
>          case -ENOKEY:
>                  reason = "module with unavailable key";
>                  break;
> -

Cosmetic

>          default:
>                  /*
> -                * All other errors are fatal, including lack of memory,
> -                * unparseable signatures, and signature check failures --
> -                * even if signatures aren't required.
> +                * All other errors are fatal, including:
> +                * - OOM
> +                * - unparseable signatures
> +                * - invalid signature failures
>                   */
>                  return err;
>          }
> diff --git a/kernel/module/signing.orig b/kernel/module/signing.orig
> new file mode 100644
> index 000000000000..a2ff4242e623
> --- /dev/null
> +++ b/kernel/module/signing.orig
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Module signature checker
> + *
> + * Copyright (C) 2012 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/module_signature.h>
> +#include <linux/string.h>
> +#include <linux/verification.h>
> +#include <linux/security.h>
> +#include <crypto/public_key.h>
> +#include <uapi/linux/module.h>
> +#include "internal.h"
> +
> +#undef MODULE_PARAM_PREFIX
> +#define MODULE_PARAM_PREFIX "module."
> +
> +static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
> +module_param(sig_enforce, bool_enable_only, 0644);
> +
> +/*
> + * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
> + * on that instead of directly to CONFIG_MODULE_SIG_FORCE config.
> + */
> +bool is_module_sig_enforced(void)
> +{
> +       return sig_enforce;
> +}
> +EXPORT_SYMBOL(is_module_sig_enforced);
> +
> +void set_module_sig_enforced(void)
> +{
> +       sig_enforce = true;
> +}
> +
> +/*
> + * Verify the signature on a module.
> + */
> +int mod_verify_sig(const void *mod, struct load_info *info)
> +{
> +       struct module_signature ms;
> +       size_t sig_len, modlen = info->len;
> +       int ret;
> +
> +       pr_devel("==>%s(,%zu)\n", __func__, modlen);
> +
> +       if (modlen <= sizeof(ms))
> +               return -EBADMSG;
> +
> +       memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
> +
> +       ret = mod_check_sig(&ms, modlen, "module");
> +       if (ret)
> +               return ret;
> +
> +       sig_len = be32_to_cpu(ms.sig_len);
> +       modlen -= sig_len + sizeof(ms);
> +       info->len = modlen;
> +
> +       return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
> +                                     VERIFY_USE_SECONDARY_KEYRING,
> +                                     VERIFYING_MODULE_SIGNATURE,
> +                                     NULL, NULL);
> +}
> +
> +int module_sig_check(struct load_info *info, int flags)
> +{
> +       int err = -ENODATA;
> +       const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
> +       const char *reason;
> +       const void *mod = info->hdr;
> +       bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
> +                                      MODULE_INIT_IGNORE_VERMAGIC);
> +       /*
> +        * Do not allow mangled modules as a module with version information
> +        * removed is no longer the module that was signed.
> +        */
> +       if (!mangled_module &&
> +           info->len > markerlen &&
> +           memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
> +               /* We truncate the module to discard the signature */
> +               info->len -= markerlen;
> +               err = mod_verify_sig(mod, info);
> +               if (!err) {
> +                       info->sig_ok = true;
> +                       return 0;
> +               }
> +       }
> +
> +       /*
> +        * We don't permit modules to be loaded into the trusted kernels
> +        * without a valid signature on them, but if we're not enforcing,
> +        * certain errors are non-fatal.
> +        */
> +       switch (err) {
> +       case -ENODATA:
> +               reason = "unsigned module";
> +               break;
> +       case -ENOPKG:
> +               reason = "module with unsupported crypto";
> +               break;
> +       case -ENOKEY:
> +               reason = "module with unavailable key";
> +               break;
> +
> +       default:
> +               /*
> +                * All other errors are fatal, including lack of memory,
> +                * unparseable signatures, and signature check failures --
> +                * even if signatures aren't required.
> +                */
> +               return err;
> +       }
> +
> +       if (is_module_sig_enforced()) {
> +               pr_notice("Loading of %s is rejected\n", reason);
> +               return -EKEYREJECTED;
> +       }
> +
> +       return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
> +}
> --
> 2.50.1.windows.1
> 
> 

