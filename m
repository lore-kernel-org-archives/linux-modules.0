Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC01ECAAA1
	for <linux-modules@archiver.kernel.org>; Tue,  6 Sep 2022 18:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiIFSMh (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 6 Sep 2022 14:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIFSMh (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 6 Sep 2022 14:12:37 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85851753A1
        for <linux-modules@vger.kernel.org>; Tue,  6 Sep 2022 11:12:36 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id bh13so11354640pgb.4
        for <linux-modules@vger.kernel.org>; Tue, 06 Sep 2022 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=a7DNmuqB5Su7+8tXdQR7ATwsDOSAcQAlczFmAXfGDQ8=;
        b=a3Tn+HGM1hnf9ZAY70kHGVmx/uGKpO9Xhn38WUGLd8chjqQ+J853y5ef5DdTmaNNZM
         NatGQrcxYUChLlyFfnwxu3E6DuqwtBld1Z/DHpD/3OV/CpXL+/O+me5AYhnx1OQiZW4w
         mqDfi26BiGfVyy8ObxkFHV1ObJE84Q2jzlVwBHZ5uMd/HTBDRtsf4uvuUqZbnY6C6Csb
         FI5vPPJElil8X8mStzMnNNokwq7HLjEOV6qYcX/UKgsmREgSaUJAO1PEA0m76k7RSlzW
         n8aS+4ItU/SZYITK7h2AzOmBRRfs8Ge+rcWGw6Da5RR1PaSgX0s0WZsMJVQvU6eZ+bHP
         wbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=a7DNmuqB5Su7+8tXdQR7ATwsDOSAcQAlczFmAXfGDQ8=;
        b=c481A5J33jU/IqmrRHdNSwajkga+sPB/zjW4cbNvT8FnYM0IZx1nI4F6dRotVAuKyB
         MFzDD43kVWXHvN3t/kEwpRY16JI/6DSXxZehBdZH/knrzFhGXAI39FZ8oL1oJXg1OEhB
         awA7VH7rFC1U4i5qUdT2Z/Cd+ftQOks9lo+6m+J+rbuTFTV8/HxCJzy1wXhKKkI+XfGh
         i4yiGi+Ywl7nxBNu/xHyIACZ/mpWrh94PeoGEYBPh4lqugvSETNoGcxlgUeCpT0VzbCN
         uKMUJgaE314EyCDdnKkEoO2OS1UnBHM0Q46k52Ff3nq3GWtXVxqZLjzz6ruJEJyq3SFu
         iVGg==
X-Gm-Message-State: ACgBeo1HILrMgVEKavlJRSy65BA6sMAUwH5HlKvuFS2391nB5Spbz8nV
        cR0/IlrUhxxywpBWs26CYOw=
X-Google-Smtp-Source: AA6agR67gfACrL9b9hYbjts9vAx14zsvuj/E2pu2fR3HaJPoqQScxTCSKe+ktFDi3C1hLzkTeFFHKw==
X-Received: by 2002:a05:6a00:301c:b0:52d:bff9:5004 with SMTP id ay28-20020a056a00301c00b0052dbff95004mr56442747pfb.84.1662487955753;
        Tue, 06 Sep 2022 11:12:35 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:1190:fbfa:ae95:111c])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db0200b0016bfbd99f64sm10301560plx.118.2022.09.06.11.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 11:12:35 -0700 (PDT)
Date:   Tue, 6 Sep 2022 11:12:32 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH resend] module/decompress: generate sysfs string at
 compile time
Message-ID: <YxeNkNy62rcPaq5k@google.com>
References: <20220906080317.15426-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906080317.15426-1-ddiss@suse.de>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Sep 06, 2022 at 10:03:18AM +0200, David Disseldorp wrote:
> compression_show() before (with noinline):
>    0xffffffff810b5ff0 <+0>:     mov    %rdx,%rdi
>    0xffffffff810b5ff3 <+3>:     mov    $0xffffffff81b55629,%rsi
>    0xffffffff810b5ffa <+10>:    mov    $0xffffffff81b0cde2,%rdx
>    0xffffffff810b6001 <+17>:    call   0xffffffff811b8fd0 <sysfs_emit>
>    0xffffffff810b6006 <+22>:    cltq
>    0xffffffff810b6008 <+24>:    ret
> 
> After:
>    0xffffffff810b5ff0 <+0>:     mov    $0xffffffff81b0cde2,%rsi
>    0xffffffff810b5ff7 <+7>:     mov    %rdx,%rdi
>    0xffffffff810b5ffa <+10>:    call   0xffffffff811b8fd0 <sysfs_emit>
>    0xffffffff810b5fff <+15>:    cltq
>    0xffffffff810b6001 <+17>:    ret
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  kernel/module/decompress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Resend: Maintainer addresses added.
> 
> Feel free to drop the to-be-expected commit message body if desired.
> 
> diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
> index 4d0bcb3d9e449..c033572d83f0e 100644
> --- a/kernel/module/decompress.c
> +++ b/kernel/module/decompress.c
> @@ -256,7 +256,7 @@ void module_decompress_cleanup(struct load_info *info)
>  static ssize_t compression_show(struct kobject *kobj,
>  				struct kobj_attribute *attr, char *buf)
>  {
> -	return sysfs_emit(buf, "%s\n", __stringify(MODULE_COMPRESSION));
> +	return sysfs_emit(buf, __stringify(MODULE_COMPRESSION) "\n");

I guess we van trust the kernel source not to put garbage into
MODULE_COMPRESSION macro.

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
