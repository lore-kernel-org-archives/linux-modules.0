Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AD2C433F5
	for <linux-modules@archiver.kernel.org>; Fri, 25 Feb 2022 10:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbiBYKeh (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 25 Feb 2022 05:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237638AbiBYKeh (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 25 Feb 2022 05:34:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F36D81E2FD1
        for <linux-modules@vger.kernel.org>; Fri, 25 Feb 2022 02:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645785244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K8IJXIhGpH0hpZ2WrQRw/kZrEheB/3ig8HjNNyMg7uw=;
        b=d2XZKF/g8N4JEvpY95r4/0YZzdsNNgzMvn4Z3RluG8zTQD2hmJgyYqYGDTGlVBHd2WDZfv
        nKJgrFjpLhqc4eWjDE8UkXGxDD2A6ZK8cpCBzcAv5C8sTp9UP1XCLZQJVSiBaxTkCwH02h
        ycpmc/6nfIPNgXOaylrWATkX+5sTn+c=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-372-OHWexNrUO3Ksl6eubncO0Q-1; Fri, 25 Feb 2022 05:34:02 -0500
X-MC-Unique: OHWexNrUO3Ksl6eubncO0Q-1
Received: by mail-lf1-f69.google.com with SMTP id d1-20020a0565123d0100b004433d2e2fd0so847477lfv.8
        for <linux-modules@vger.kernel.org>; Fri, 25 Feb 2022 02:34:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8IJXIhGpH0hpZ2WrQRw/kZrEheB/3ig8HjNNyMg7uw=;
        b=T4nprI6rIPpjS4URQSQsI3XBRCHSyV68MKlKGfqE6JVsEin16plciXlAO+rG7KVuWh
         HVM9/MxBRdNdVJyYMQZFp8Pvj70sZr9YjeckBD3LBATQEIY3GcIR+4VSuUFElbPnHoOz
         vUyMJWq5s5P+OsVV1mqDqpASIOMWp3PMvfyZ3b3SZn5cZAQyG2OcUA/vcl8sONETgt/d
         sqrkWsJujNy0JB6pKqZEu1B8pC2Ir9j9sZEK1RqFt9oul2b6+mpSln7n1nkXoi33Y7nU
         qkVUeS92avTEG+lwdbmg1LKxeBrQ1eXy+uGvFH8KbISYUxbwmVMWZs5gFuSrwjrjpF+6
         hkXg==
X-Gm-Message-State: AOAM532cI2J2UHDtl+9TAOx0sNfQ1pVwra1SX++ck+mOog7EJ/Jsin1Q
        EKSdxJqLklogD5dHK5dp5G4JEYoqANDr8ezTzTLkvthh09pRMdUyl7+kIPgbIJHaSUIBcTC6e0b
        gQb4XiErkES+axM5w8Ntd6Ok7Tv+8JgLm2N9XJVTw
X-Received: by 2002:a2e:88d6:0:b0:245:f22e:5125 with SMTP id a22-20020a2e88d6000000b00245f22e5125mr4712582ljk.529.1645785241183;
        Fri, 25 Feb 2022 02:34:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxtUjupboRAzjq5CuwRyXIz+lvrJskcLy8gmAL34wrQuNAR5/WaTSpikJrYHdCD1jvG6QiOMBbt4TFAE0Rv/1s=
X-Received: by 2002:a2e:88d6:0:b0:245:f22e:5125 with SMTP id
 a22-20020a2e88d6000000b00245f22e5125mr4712576ljk.529.1645785240994; Fri, 25
 Feb 2022 02:34:00 -0800 (PST)
MIME-Version: 1.0
References: <20220222141303.1392190-1-atomlin@redhat.com> <20220222141303.1392190-5-atomlin@redhat.com>
 <Yhiik2ledqAfGuN2@alley>
In-Reply-To: <Yhiik2ledqAfGuN2@alley>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Fri, 25 Feb 2022 10:33:49 +0000
Message-ID: <CANfR36ho7ccXWSU0+ZP3yN39WDgoKS-2WvVQdM1ONG_15Vk=8Q@mail.gmail.com>
Subject: Re: [PATCH v8 04/13] module: Move livepatch support to a separate file
To:     Petr Mladek <pmladek@suse.com>
Cc:     "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Lameter, Christoph" <cl@linux.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, jeyu@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, void@manifault.com,
        Aaron Tomlin <atomlin@atomlin.com>,
        Allen <allen.lkml@gmail.com>, Joe Perches <joe@perches.com>,
        Michal Suchanek <msuchanek@suse.de>, oleksandr@natalenko.name
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri 2022-02-25 10:34 +0100, Petr Mladek wrote:
> This code include several other well hidden changes:
>
> --- del.p    2022-02-24 16:55:26.570054922 +0100
> +++ add.p    2022-02-24 16:56:04.766781394 +0100
> @@ -3,14 +3,14 @@
>   * section header table, section string table, and symtab section
>   * index from info to mod->klp_info.
>   */
> -static int copy_module_elf(struct module *mod, struct load_info *info)
> +int copy_module_elf(struct module *mod, struct load_info *info)
>  {
>      unsigned int size, symndx;
>      int ret;
>
>      size = sizeof(*mod->klp_info);
>      mod->klp_info = kmalloc(size, GFP_KERNEL);
> -    if (mod->klp_info == NULL)
> +    if (!mod->klp_info)
>          return -ENOMEM;
>
>      /* Elf header */
> @@ -20,7 +20,7 @@ static int copy_module_elf(struct module
>      /* Elf section header table */
>      size = sizeof(*info->sechdrs) * info->hdr->e_shnum;
>      mod->klp_info->sechdrs = kmemdup(info->sechdrs, size, GFP_KERNEL);
> -    if (mod->klp_info->sechdrs == NULL) {
> +    if (!mod->klp_info->sechdrs) {
>          ret = -ENOMEM;
>          goto free_info;
>      }
> @@ -28,7 +28,7 @@ static int copy_module_elf(struct module
>      /* Elf section name string table */
>      size = info->sechdrs[info->hdr->e_shstrndx].sh_size;
>      mod->klp_info->secstrings = kmemdup(info->secstrings, size, GFP_KERNEL);
> -    if (mod->klp_info->secstrings == NULL) {
> +    if (!mod->klp_info->secstrings) {
>          ret = -ENOMEM;
>          goto free_sechdrs;
>      }
> @@ -43,8 +43,7 @@ static int copy_module_elf(struct module
>       * to core_kallsyms.symtab since the copy of the symtab in module
>       * init memory is freed at the end of do_init_module().
>       */
> -    mod->klp_info->sechdrs[symndx].sh_addr = \
> -        (unsigned long) mod->core_kallsyms.symtab;
> +    mod->klp_info->sechdrs[symndx].sh_addr = (unsigned long)mod->core_kallsyms.symtab;
>
>      return 0;
>
>
> Please do not do these small coding style changes. It complicates the
> review and increases the risk of regressions. Different people
> have different preferences. Just imagine that every half a year
> someone update style of a code by his personal preferences. The
> real changes will then get lost in a lot of noise.
>
> Coding style changes might be acceptable only when the code is
> reworked or when it significantly improves readability.
>
>
> That said. I reviewed and tested this patch and did not find any
> problem. Feel free to use:
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Tested-by: Petr Mladek <pmladek@suse.com>
>
> Please, take the above as an advice for your future work.

Hi Petr,

Firstly, thank you for your feedback. Fair enough and noted.


Kind regards,

-- 
Aaron Tomlin

