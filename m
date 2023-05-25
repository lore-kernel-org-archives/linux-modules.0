Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D839C7EE2F
	for <linux-modules@archiver.kernel.org>; Thu, 25 May 2023 17:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbjEYRxW (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 25 May 2023 13:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbjEYRxV (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 25 May 2023 13:53:21 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CF01A1
        for <linux-modules@vger.kernel.org>; Thu, 25 May 2023 10:53:17 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-973bf581759so128109966b.0
        for <linux-modules@vger.kernel.org>; Thu, 25 May 2023 10:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685037196; x=1687629196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cki7nTSfn8V9Pz9bjx+wUZ3Q24K9M6RV4kOzAoI4Ezk=;
        b=D6d6iUjkz46uF5lcM4xKnjVBYMFgwmzQC2Gv7q7jtoXAmTPH31SoeNZ0EYsFNq1HCL
         FHpt6Dqayp7iUP4uroXvnZ9Te7yirPRkuvgSsmVXAi+VukHYxVB1yXCM7U/snsD/n8G+
         YDlUCHjvQ7SUxSCmocrK/cFYALfbBFxqZRtjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685037196; x=1687629196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cki7nTSfn8V9Pz9bjx+wUZ3Q24K9M6RV4kOzAoI4Ezk=;
        b=Fs6XL6uqbiGiEGmdwEDmewJorZVwoP0SyrX5Iq64peaRuQjLs9bZHAv4Rt8FV5vbOu
         cjf0yBMyw6svJrFKU8QkJ0FBM+c90fayr14I1HWVm//v44UsP2b9VvAn0WW7m5h3QMDV
         9vDQ3526xqK1SzclsLWjKgWoo+M8h4uCoBlrs8qkfMg+bMBpzqyxVmLGJoFJsjIuHmjm
         WhbjxtP4UWhUg2Z7DTpsQfUj//elkgbkEtU4jQeku2VbqShIqZU+dPD5LxY4u9eXwIDG
         71irvZD3JuLRgZ++94qEjtSsEDMPqc/3jQbCigQmcQMaQB8LCsQ+ZZZR4vqQnb4A48PL
         VHfA==
X-Gm-Message-State: AC+VfDzsDNaTDTXApPV/QYZL7MicfqS4CyBLKlYv5e10XGXFupzvHwVZ
        9PmPUSaybwBPWipLX1sWqdifFR8fMRnESwO7S0ohtzcq
X-Google-Smtp-Source: ACHHUZ58HRQeFW36yaEkura+2yDfr+syN9nhmjDO1nwrfy1PbMCD+HP8/XV3G7jB7HMDybHxUX1VzA==
X-Received: by 2002:a17:907:31c6:b0:973:903c:35a4 with SMTP id xf6-20020a17090731c600b00973903c35a4mr2444919ejb.65.1685037196076;
        Thu, 25 May 2023 10:53:16 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id ba4-20020a0564021ac400b005068fe6f3d8sm762852edb.87.2023.05.25.10.53.15
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 10:53:15 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-513fd8cc029so4948920a12.3
        for <linux-modules@vger.kernel.org>; Thu, 25 May 2023 10:53:15 -0700 (PDT)
X-Received: by 2002:a17:907:9493:b0:965:fa80:bf1 with SMTP id
 dm19-20020a170907949300b00965fa800bf1mr2195225ejc.32.1685037174582; Thu, 25
 May 2023 10:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230524213620.3509138-1-mcgrof@kernel.org> <20230524213620.3509138-3-mcgrof@kernel.org>
 <8fc5b26b-d2f6-0c8f-34a1-af085dbef155@suse.com> <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 May 2023 10:52:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjWeV-ct7pFvBF6m1gzbqdp_K7nQe=++Ov029g6Fc3dsg@mail.gmail.com>
Message-ID: <CAHk-=wjWeV-ct7pFvBF6m1gzbqdp_K7nQe=++Ov029g6Fc3dsg@mail.gmail.com>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, gregkh@linuxfoundation.org,
        rafael@kernel.org, song@kernel.org, lucas.de.marchi@gmail.com,
        lucas.demarchi@intel.com, christophe.leroy@csgroup.eu,
        peterz@infradead.org, rppt@kernel.org, dave@stgolabs.net,
        willy@infradead.org, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com, colin.i.king@gmail.com,
        jim.cromie@gmail.com, catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com, david@redhat.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu, May 25, 2023 at 9:07=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> That said, I posted an alternate patch that I think _is_ valid as that
> quick hack. I don't love it, but it sure is simpler (and avoids the
> i_ino bug):
>
>     https://lore.kernel.org/lkml/CAHk-=3DwgKu=3DtJf1bm_dtme4Hde4zTB=3D_7E=
dgR8avsDRK4_jD+uA@mail.gmail.com/
>
> that patch hasn't seen any testing, and for all I know it won't even
> boot because of some thinko, but I think it would be acceptable as a
> workaround if it does work.

Well, it boots here, so it must be perfect.

That said, I didn't add any debugging code, and I didn't test it on
any odd setups, and I've never had any problems before. So I don't
actually know if the patch *does* anything.

But it did boot..

               Linus
