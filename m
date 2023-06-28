Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716A8EB64DC
	for <linux-modules@archiver.kernel.org>; Wed, 28 Jun 2023 23:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjF1XRz (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 28 Jun 2023 19:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjF1XRy (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 28 Jun 2023 19:17:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807822102
        for <linux-modules@vger.kernel.org>; Wed, 28 Jun 2023 16:17:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-986d8332f50so10078366b.0
        for <linux-modules@vger.kernel.org>; Wed, 28 Jun 2023 16:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687994271; x=1690586271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oM8+DBVW7RHSb20wzupU3eI3vgm5LTctM5Hspz2fXBo=;
        b=LJNm5YxqiMRwvHrJWhWuoG7pbWB1YQfzTmNaxjmfgNRbUqTuOGhfpfvRkWzOyH6G8q
         RgQoDstaZn3gOqEcWV5gmzzJoy1njmfeVrk+n/O2dPUFgid3pCpeh1oqYFs2dJV1LHIl
         QhoJ4e0oYwy1fxbnsksyJuiaRLeUc6oigG+aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687994271; x=1690586271;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oM8+DBVW7RHSb20wzupU3eI3vgm5LTctM5Hspz2fXBo=;
        b=ChS4xp2RQVRy9CFCzeKB8Y0f6m0fMGEQJBM7HbO+FffbjMG5KXBbeKYkpLtlgzvqFa
         AGo487PG53V+Cm2/drzTsYcOsgK/175aZ+a9S0KYhaYzScSu6om2lB4P2Bd8NyZsAaPN
         /KOcQa1cryim+0kCs8c3nmn8c1l3zE+IkC0jk7k1PCB90YvyaytyBkYI4tWx1wfRbjc8
         GrplSiwpKeFeUkQ8uTSyu4alLn8F9TQ/xw3BP+1poNeK9fjZgTx7sfXs6gsMsSfvePdK
         saDfzQxvKv5+jjqKYwuV2eCl1/CNbjJcGI3+E9n5x8zYrX4Vhl5z36Qk/ZIO2W6pHaO9
         bZ4g==
X-Gm-Message-State: AC+VfDy4Fgvwz1AQXt3xcvBs6qwdr3uITWFkLVfxmB1g7B/o2lpia86e
        KYKzQo1peMXLv92HrG3S5OtA+PKDA673m4BnGmNYmxKp
X-Google-Smtp-Source: ACHHUZ7uzcQHTmUcEcS/LNTvc5sS4pyBETduIO2yfuzzAyKG8ROjAszuAszIk/10nA6RW2onOBNeAA==
X-Received: by 2002:a17:907:3f17:b0:965:6b9e:7ded with SMTP id hq23-20020a1709073f1700b009656b9e7dedmr32522765ejc.42.1687994270895;
        Wed, 28 Jun 2023 16:17:50 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090655cf00b00992099223a0sm2599317ejp.103.2023.06.28.16.17.49
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 16:17:50 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so88477a12.0
        for <linux-modules@vger.kernel.org>; Wed, 28 Jun 2023 16:17:49 -0700 (PDT)
X-Received: by 2002:a19:380f:0:b0:4f8:4177:e087 with SMTP id
 f15-20020a19380f000000b004f84177e087mr20100079lfa.47.1687994248313; Wed, 28
 Jun 2023 16:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <ZHTCK2_1pF61yWIr@hovoldconsulting.com> <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
 <ZHYitt7P7W+8ZlSB@bombadil.infradead.org> <499e30cc-d015-8353-1364-50d17da58f47@redhat.com>
 <ZHd8bLPY4OQCb/Z5@bombadil.infradead.org> <ba60bca6-b682-4c27-3c54-2512b6f16151@redhat.com>
 <ZHoTFDkPIgglW0sU@bombadil.infradead.org> <fa3f1a1f-edc6-f13b-cc84-f3264b03b0b1@redhat.com>
 <ZH38lpTHZ/RISC1v@bombadil.infradead.org> <ZH3/KVCHhX4D4yh9@bombadil.infradead.org>
 <ZJyBhv6yrAfYvMh5@bombadil.infradead.org> <CAHk-=wiSRTEOgiDA5qUTPGcw=Fbk9Ou2i97kfSBcj3pey3X=fQ@mail.gmail.com>
 <CAHk-=wgPz4Fj9M_h7sRSHAK9QeJiTFaYMWX3fDyZ-Bj41HftmA@mail.gmail.com>
In-Reply-To: <CAHk-=wgPz4Fj9M_h7sRSHAK9QeJiTFaYMWX3fDyZ-Bj41HftmA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Jun 2023 16:17:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh80e=+_6UrHLdXMbJJ58Jz2YtMidc95HBT8raNy325nQ@mail.gmail.com>
Message-ID: <CAHk-=wh80e=+_6UrHLdXMbJJ58Jz2YtMidc95HBT8raNy325nQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, song@kernel.org,
        Johan Hovold <johan@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Petr Pavlu <petr.pavlu@suse.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, lucas.de.marchi@gmail.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed, 28 Jun 2023 at 15:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, since I clearly didn't communicate clearly that I was throwing
> the patch over to you, let me go and find it and just apply it myself.

Ok, I spent some time writing a better commit message for that change,
tried to make sure I got everybody's comments and Tested-by's sorted
out etc, and committed the end result.

I also did the actual module pull and your sysctl pull.

Can you please check that it all looks like you expected?

              Linus
