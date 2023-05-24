Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D49FC77B7C
	for <linux-modules@archiver.kernel.org>; Wed, 24 May 2023 22:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjEXWEa (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 24 May 2023 18:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEXWE3 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 24 May 2023 18:04:29 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E0C10B
        for <linux-modules@vger.kernel.org>; Wed, 24 May 2023 15:04:28 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2af1a7d2f6aso18222481fa.1
        for <linux-modules@vger.kernel.org>; Wed, 24 May 2023 15:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684965867; x=1687557867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGJNYAB8T/lr+YL5tSEXLDHHn2s+eih/Ya1hsZucDVU=;
        b=SATUpcur5IGtORuSPldHZecqLQCkofDQdTInHq1pL4I/TJlHliQXom3vIKvWPAJb7x
         a9veaA5aNY6eEv9qRGqqt7ZW7HAwkRU+Z29v6k4LBgqeQGybundyguFuxTsolQNUXU9+
         gS3eb59uETRyQ+6WAmdDIXcyoTyZwzpv0f0gA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684965867; x=1687557867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGJNYAB8T/lr+YL5tSEXLDHHn2s+eih/Ya1hsZucDVU=;
        b=RYXVc/p+/pNNAA16pwA6ghIi+gygIbGiOk50C/moBxImhcB+EOM9oWFqWaGkHv2o0j
         pgXX8z/dC9rUFghEBI3bHg/5QW7LP+l6gfZQRHFYIh+iL0mbx1X2cLo0wCkB7T2mLn6+
         wyj+crItGS5YQnzTFlfL2ilqiv8GkQwAykVT6ZG3aXGD/6OWJoF0Wvb3TDfrS8pMIC5V
         rbqVAHimPTJVen0vFwsjLsnTU4uyyRQvyXE7sk4VuBk+wuu9SkyncJqEddiUjbKfwkDD
         2jAP6cHAI16txRUSbQ4V5dhYUl1dO+fbACupfvwJsJiBvhFfaRIhQ0/xkTRrFr0f1eoz
         hvBA==
X-Gm-Message-State: AC+VfDzm2Bh5/4pQCtXAVYyDBfsJXeLO5gwUcmqzCUPMCyuBZ2zfFGJe
        z7r4wKAa3dNUytmrqeAiVn6/T7/3ZTqtgWMH4lKvfTLU
X-Google-Smtp-Source: ACHHUZ6+ODqBlcxU/u6jHdlOgdsIyyjnvdC6mZfN7iyevhUPBi1uzGA+K7O9u6loS3RWURsz0aQNng==
X-Received: by 2002:a2e:9647:0:b0:2ac:8283:b67d with SMTP id z7-20020a2e9647000000b002ac8283b67dmr315784ljh.25.1684965866887;
        Wed, 24 May 2023 15:04:26 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id m4-20020a2e9104000000b002adb10a6620sm2180367ljg.107.2023.05.24.15.04.26
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 15:04:26 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f3b4ed6fdeso1510029e87.3
        for <linux-modules@vger.kernel.org>; Wed, 24 May 2023 15:04:26 -0700 (PDT)
X-Received: by 2002:a17:907:268c:b0:96f:65db:d6d2 with SMTP id
 bn12-20020a170907268c00b0096f65dbd6d2mr16749757ejc.14.1684965423649; Wed, 24
 May 2023 14:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230524213620.3509138-1-mcgrof@kernel.org> <20230524213620.3509138-2-mcgrof@kernel.org>
 <CAHk-=wjahcAqLYm0ijcAVcPcQAz-UUuJ3Ubx4GzP_SJAupf=qQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjahcAqLYm0ijcAVcPcQAz-UUuJ3Ubx4GzP_SJAupf=qQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 May 2023 14:56:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9oPrxcMK469X0zAueKQ4tqX80SdFqCx9StcL82vuEkw@mail.gmail.com>
Message-ID: <CAHk-=wi9oPrxcMK469X0zAueKQ4tqX80SdFqCx9StcL82vuEkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/kernel_read_file: add support for duplicate detection
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     david@redhat.com, tglx@linutronix.de, hch@lst.de,
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

On Wed, May 24, 2023 at 2:52=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Stop adding horrific code for some made-up load that isn't real.

Even if you trigger some "worst case 3x memory use", that is
_temporary_, and will be free'd in the end.

The patches to "fix" this are worse than the disease.

                  Linus
