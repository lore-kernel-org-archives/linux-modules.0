Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D377C4332F
	for <linux-modules@archiver.kernel.org>; Wed, 11 May 2022 19:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346786AbiEKTvS (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 11 May 2022 15:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347293AbiEKTvN (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 11 May 2022 15:51:13 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E391A3D4B0
        for <linux-modules@vger.kernel.org>; Wed, 11 May 2022 12:51:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ch13so6069892ejb.12
        for <linux-modules@vger.kernel.org>; Wed, 11 May 2022 12:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=okDasmSIedZIfDNVfGzL/C0tlLQxT7cXpy43/5U1qMo=;
        b=QUS04llQ/TQdvF3bJLtNkYv+9Y/6CRyA1IhJj03bD1ysf9ANin3YF7pIozL2ckCVd9
         OEgvjLcrm/1wDU9oB6CTsdkJp6bSY0dGxFMc0XUZpQx5vjtv+lpaWgY+z91+b2dCfgUQ
         oJPZmG2v8C8OYJmWR8Lmy78eHPjrvYJULiRqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=okDasmSIedZIfDNVfGzL/C0tlLQxT7cXpy43/5U1qMo=;
        b=ssUJuPFFzDqKxSqPiIVRxykPBt2uNXqhG6eRSQXH4vNzxVpkVC0vxxYPxTBsIihfbi
         ktLgyYxV09CkzceRuQmf2QKuYCUQaQLekwP12Ng1r7+TdkiaYpUpDr4dIrC5Ql5BK878
         2wFvrnu9HRmsIDYaiGaIA4lWEz+3V2VgrP/JqU+62JmV5ToWp33oGRBG718ZeqtBUZgn
         +ThIhOP/oeyP5DEh9pkEHwmtLuWi2aQn6VetwUpH+XMbBmsR6z9YbxioCLB6qCbXYz51
         +LARpBtt+vBXzcLEeUMRNwbkR8Cm0E3ZcFSzg1YfK2YYUv+WRcB360u9GNKQPyASv8ez
         rTwA==
X-Gm-Message-State: AOAM532FuEDlLsKgFyt7SM0ev1MaSJSqpF0hmnfSD9kC42oHo6x/wcJO
        qXysd2DuNCaYjT+zvMj9QuUM9w==
X-Google-Smtp-Source: ABdhPJzc30UDk4ot2UfqIn3JcPVtx5jKy3U9yzEWlwhCj1FbId8oXyy3bEiSM7KRq59c9iZ9/8xhUg==
X-Received: by 2002:a17:906:b74b:b0:6f4:cd08:6fec with SMTP id fx11-20020a170906b74b00b006f4cd086fecmr28194512ejb.155.1652298670454;
        Wed, 11 May 2022 12:51:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id cb13-20020a0564020b6d00b0042617ba639asm1598568edb.36.2022.05.11.12.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 12:51:09 -0700 (PDT)
Date:   Wed, 11 May 2022 21:51:08 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        mauro.chehab@linux.intel.com, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v6 4/4] ALSA: hda - identify when audio is provided by a
 video driver
Message-ID: <YnwTrF6VpM7V1jdu@phenom.ffwll.local>
Mail-Followup-To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        mauro.chehab@linux.intel.com, Takashi Iwai <tiwai@suse.de>
References: <cover.1652113087.git.mchehab@kernel.org>
 <f53f8a9d04b39a6843f19fe3069d1be7a9713aae.1652113087.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f53f8a9d04b39a6843f19fe3069d1be7a9713aae.1652113087.git.mchehab@kernel.org>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon, May 09, 2022 at 06:23:39PM +0200, Mauro Carvalho Chehab wrote:
> On some devices, the hda driver needs to hook into a video driver,
> in order to be able to properly access the audio hardware and/or
> the power management function.
> 
> That's the case of several snd_hda_intel devices that depends on
> i915 driver.
> 
> Ensure that a proper reference between the snd-hda driver needing
> such binding is shown at /proc/modules, in order to allow userspace
> to know about such binding.
> 
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
> 
> See [PATCH v6 0/4] at: https://lore.kernel.org/all/cover.1652113087.git.mchehab@kernel.org/
> 
>  sound/hda/hdac_component.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/hda/hdac_component.c b/sound/hda/hdac_component.c
> index bb37e7e0bd79..7789873ddf47 100644
> --- a/sound/hda/hdac_component.c
> +++ b/sound/hda/hdac_component.c
> @@ -199,7 +199,7 @@ static int hdac_component_master_bind(struct device *dev)
>  	}
>  
>  	/* pin the module to avoid dynamic unbinding, but only if given */
> -	if (!try_module_get(acomp->ops->owner)) {
> +	if (!try_module_get_owner(acomp->ops->owner, dev->driver->owner)) {

I'm still a bit confused why snd-hda does this and why this wasn't put
into component.c, but that's kinda a pre-existing issue and I guess could
be fixed later on. It really shouldn't be anything specific to snd-hda
here.

Anyway I scrolled through the series, it makes a lot more sense than the
intial hack to me, so on the series:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

But maybe don't count that as real review :-)

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
