Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1907C77B7A
	for <linux-modules@archiver.kernel.org>; Thu, 25 May 2023 20:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240832AbjEYUIr (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 25 May 2023 16:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbjEYUIq (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 25 May 2023 16:08:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2004EA9
        for <linux-modules@vger.kernel.org>; Thu, 25 May 2023 13:08:44 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3095557dd99so2497141f8f.1
        for <linux-modules@vger.kernel.org>; Thu, 25 May 2023 13:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685045322; x=1687637322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIsIFxmLlj97Nfx6D9vKSgsX1a6jDH3TwyPUkCdOSPQ=;
        b=NfHUuPqrYbkYfaJLYZsBrLcXLQRoBIy987P60Cb1gnvLRhrIhe4KBMlVsgiG7UUgVw
         WVV33SCrrt339T4kMyxHGzTyd7rwigoc+GKyVMTHL6aWghrX+1TCpAItGtsR5OVRu03X
         Gr9zjwH15243EBBGSdUuvVy/cqnkehFB4vrPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685045322; x=1687637322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aIsIFxmLlj97Nfx6D9vKSgsX1a6jDH3TwyPUkCdOSPQ=;
        b=Pz+sJSMo2O3DS8RimZ/cng2zX0fqVTlTuaLb+FWZz7isSNZpX7VAM3JiakAMuuv2kV
         w/eo4HX/+yhdKOGvfKjUgCKLiStahgtfoWeMrVG2/9UL4ES6IXSsgJeyMwVDetcDk0FY
         jr5tSmsaqXKWmw4uuqBkkJqiFqRrTBoy9zGQd+n6vPX0KFt3ti59k6H2ua+P8N7dQeOZ
         JIejaBgvyFzgJtQaekGWLH6Z9932zriM/wG6uhGJXaAc2eJKrmOyDzgraGfJtZv3EkS+
         jf+pl6kVfJ/ZAeiRcB90t3iorTBpg9/xQyIpxptL2obVrXUuRrCJl8wqhgtH/t1v6DWm
         e41Q==
X-Gm-Message-State: AC+VfDzHK5TIgmCyTNZOY6K1x+g5HxbDZF1an7pjmFV6ATP75++uaUNU
        GC+7e85dgKYi+TG/9ulU9YAKE4WvsForNr9piL8Z3CBo
X-Google-Smtp-Source: ACHHUZ7zLP5zR+E4+CH585Ugglw3aRDFeUqd/mT5NGKbile0CwZhylBcDiig1CG3aXCmoiVVUWta4A==
X-Received: by 2002:a17:906:9f25:b0:96f:675d:491f with SMTP id fy37-20020a1709069f2500b0096f675d491fmr2927700ejc.57.1685040640329;
        Thu, 25 May 2023 11:50:40 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id j13-20020a170906254d00b0096a6be0b66dsm1160086ejb.208.2023.05.25.11.50.39
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 11:50:39 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-510dabb39aeso4405713a12.2
        for <linux-modules@vger.kernel.org>; Thu, 25 May 2023 11:50:39 -0700 (PDT)
X-Received: by 2002:a17:907:6d9e:b0:96f:4ee4:10d4 with SMTP id
 sb30-20020a1709076d9e00b0096f4ee410d4mr2465428ejc.43.1685040638863; Thu, 25
 May 2023 11:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230524213620.3509138-1-mcgrof@kernel.org> <20230524213620.3509138-2-mcgrof@kernel.org>
 <CAHk-=wjahcAqLYm0ijcAVcPcQAz-UUuJ3Ubx4GzP_SJAupf=qQ@mail.gmail.com>
 <CAHk-=wgKu=tJf1bm_dtme4Hde4zTB=_7EdgR8avsDRK4_jD+uA@mail.gmail.com> <ZG+kDevFH6uE1I/j@bombadil.infradead.org>
In-Reply-To: <ZG+kDevFH6uE1I/j@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 11:50:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWCDw58fZDLGYVqVC2ee-Zec25unewdHFp8syCZFumvg@mail.gmail.com>
Message-ID: <CAHk-=wgWCDw58fZDLGYVqVC2ee-Zec25unewdHFp8syCZFumvg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/kernel_read_file: add support for duplicate detection
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>, hch@lst.de,
        brauner@kernel.org, david@redhat.com, tglx@linutronix.de,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com, lennart@poettering.net,
        gregkh@linuxfoundation.org, rafael@kernel.org, song@kernel.org,
        lucas.de.marchi@gmail.com, lucas.demarchi@intel.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, May 25, 2023 at 11:08=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
>
> Certainly on the track where I wish we could go. Now this goes tested.
> On 255 cores:
>
> Before:
>
> vagrant@kmod ~ $ sudo systemd-analyze
> Startup finished in 41.653s (kernel) + 44.305s (userspace) =3D 1min 25.95=
8s
> graphical.target reached after 44.178s in userspace.
>
> root@kmod ~ # grep "Virtual mem wasted bytes" /sys/kernel/debug/modules/s=
tats
>  Virtual mem wasted bytes       1949006968
>
>
> ; 1949006968/1024/1024/1024
>         ~1.81515418738126754761
>
> So ~1.8 GiB... of vmalloc space wasted during boot.
>
> After:
>
> systemd-analyze
> Startup finished in 24.438s (kernel) + 41.278s (userspace) =3D 1min 5.717=
s
> graphical.target reached after 41.154s in userspace.
>
> root@kmod ~ # grep "Virtual mem wasted bytes" /sys/kernel/debug/modules/s=
tats
>  Virtual mem wasted bytes       354413398
>
> So still 337.99 MiB of vmalloc space wasted during boot due to
> duplicates.

Ok. I think this will count as 'good enough for mitigation purposes'

> The reason is the exclusive_deny_write_access() must be
> kept during the life of the module otherwise as soon as it is done
> others can still race to load

Yes. The exclusion only applies while the file is actively being read.

> So with two other hunks added (2nd and 4th), this now matches parity with
> my patch, not suggesting this is right,

Yeah, we can't do that, because user space may quite validly want to
write the file afterwards.

Or, in fact, unload the module and re-load it.

So the "exclusion" really needs to be purely temporary.

That said, I considered moving the exclusion to module/main.c itself,
rather than the reading part. That wouild get rid of the hacky "id =3D=3D
READING_MODULE", and put the exclusion in the place that actually
wants it.

And that would allow us to at least extend that temporary exlusion a
bit - we could keep it until the module has actually been loaded and
inited.

So it would probably improve on those numbers a bit more, but you'd
still have the fundamental race where *serial* duplicates end up
always wasting CPU effort and temporary vmalloc space.

                   Linus
