Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77B3C433EF
	for <linux-modules@archiver.kernel.org>; Thu,  2 Jun 2022 19:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238623AbiFBTfV (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 2 Jun 2022 15:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiFBTfU (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 2 Jun 2022 15:35:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDF93193ED
        for <linux-modules@vger.kernel.org>; Thu,  2 Jun 2022 12:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654198517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O9PSBzdnKMT+FM2cj/OdoR4tUXJ2CeB5NwQy7//IHvk=;
        b=LNxaXs3/8d1BJJx082tten2usrtkAjd7E8INUbVBNTDq64yZhA9RqgBY2wHp3aFv3Hi/3i
        YnJEFbCpm2LdigjRFVjtcUmbu6X3PhVfix2+DluYG+mKmc6JssKG9x+elhsVcxMasfSQy/
        vDXvvPmSeM5fQ4IDXppPuvhs3F4CU7o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-DsDyCGarMp-RtmJbncCNuQ-1; Thu, 02 Jun 2022 15:35:16 -0400
X-MC-Unique: DsDyCGarMp-RtmJbncCNuQ-1
Received: by mail-wm1-f70.google.com with SMTP id z19-20020a7bc153000000b0039c34ca52d4so1178540wmi.8
        for <linux-modules@vger.kernel.org>; Thu, 02 Jun 2022 12:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O9PSBzdnKMT+FM2cj/OdoR4tUXJ2CeB5NwQy7//IHvk=;
        b=3gJDubzVTmnnk1Q5+pZEQA2vTxS1u3Z7rjwcf0WiEO/RRpacE+Ggkm5swk/GXumb7v
         M2V/KF0IbiPgS6HZUTBhAW2tC3An2xKS8G38aZUGJx2X9QQh48QffeARxZf+QYl93yEM
         wHzCr+SYMJphLEP5lwGdJ3xUlRkHgTjQiiKOwg2wm71XNzGnH3L0foCU55hkHc0Q0d9C
         Iws02xTtMjo0ffbQNq6UR+F4YglAGZa7PiWxzsWrLc3t9bpaYtoaljOSPj+CelGlWTov
         XnxUE2ZKFRLcRXeg/3Omq/+OAdfhIKCD4zA9B9HkYo1VLlMDxHL7T6tLrE8fAp31nsb5
         LczQ==
X-Gm-Message-State: AOAM530oErjp92CQ7v/OcKNnAu2604D5tt/764htq3qR/8zZcogJaFgF
        prK9l3oi8Dog+PgAX0zHoEgo1Fgb1hrYNvDfCqQbEyBoOUjLoqWgjTabDAqNFU7W3pstR3AAtek
        wEwgQNXES+6YoI1N3rNXT/7Uk
X-Received: by 2002:adf:d1c4:0:b0:210:18e6:7eb8 with SMTP id b4-20020adfd1c4000000b0021018e67eb8mr4929393wrd.462.1654198515600;
        Thu, 02 Jun 2022 12:35:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMQXyJVqb+ZOZGnAocek9RLiVloAhoCka71UNYL3cPwFxy1S54RUOGmwqRt/EazubZXzOnCg==
X-Received: by 2002:adf:d1c4:0:b0:210:18e6:7eb8 with SMTP id b4-20020adfd1c4000000b0021018e67eb8mr4929380wrd.462.1654198515378;
        Thu, 02 Jun 2022 12:35:15 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d4dcc000000b002100316b126sm5378540wru.6.2022.06.02.12.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 12:35:14 -0700 (PDT)
Date:   Thu, 2 Jun 2022 20:35:13 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>, cl@linux.com,
        mbenes@suse.cz, akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org,
        kernel-team@android.com
Subject: Re: [PATCH v1] module: Fix prefix for module.sig_enforce module param
Message-ID: <20220602193513.ppya4als32dkvv4l@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220322140344.556474-2-atomlin@redhat.com>
 <20220602035653.4167316-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220602035653.4167316-1-saravanak@google.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed 2022-06-01 20:56 -0700, Saravana Kannan wrote:
> Commit cfc1d277891e ("module: Move all into module/") changed the prefix
> of the module param by moving/renaming files. A later commit also moves
> the module_param() into a different file, thereby changing the prefix
> yet again.
> 
> This would break kernel cmdline compatibility and also userspace
> compatibility at /sys/module/module/parameters/sig_enforce.
> 
> So, set the prefix back to "module.".
> 
> Cc: Aaron Tomlin <atomlin@redhat.com>
> Cc: mcgrof@kernel.org
> Cc: christophe.leroy@csgroup.eu
> Cc: cl@linux.com
> Cc: mbenes@suse.cz
> Cc: akpm@linux-foundation.org
> Cc: jeyu@kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-modules@vger.kernel.org
> Cc: void@manifault.com
> Cc: atomlin@atomlin.com
> Cc: allen.lkml@gmail.com
> Cc: joe@perches.com
> Cc: msuchanek@suse.de
> Cc: oleksandr@natalenko.name
> Cc: jason.wessel@windriver.com
> Cc: pmladek@suse.com
> Cc: daniel.thompson@linaro.org
> Cc: hch@infradead.org
> Fixes: cfc1d277891e ("module: Move all into module/")
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> Sending this patch in case my analysis in [1] was right.
> 
> [1] - https://lore.kernel.org/lkml/20220602034111.4163292-1-saravanak@google.com/
> 
> -Saravana
> 
>  kernel/module/signing.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/module/signing.c b/kernel/module/signing.c
> index 85c8999dfecf..6b0672e4417b 100644
> --- a/kernel/module/signing.c
> +++ b/kernel/module/signing.c
> @@ -16,6 +16,11 @@
>  #include <uapi/linux/module.h>
>  #include "internal.h"
>  
> +#ifdef MODULE_PARAM_PREFIX
> +#undef MODULE_PARAM_PREFIX
> +#endif
> +#define MODULE_PARAM_PREFIX "module."
> +
>  static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
>  module_param(sig_enforce, bool_enable_only, 0644);
>  
> -- 
> 2.36.1.255.ge46751e96f-goog
> 

Oops! Thanks Saravana.

Reviewed-by: Aaron Tomlin <atomlin@redhat.com>

-- 
Aaron Tomlin

