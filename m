Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE30BEB64D7
	for <linux-modules@archiver.kernel.org>; Wed, 28 Jun 2023 22:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjF1WH5 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 28 Jun 2023 18:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjF1WH4 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 28 Jun 2023 18:07:56 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973D0210B
        for <linux-modules@vger.kernel.org>; Wed, 28 Jun 2023 15:07:53 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b69f71a7easo402261fa.1
        for <linux-modules@vger.kernel.org>; Wed, 28 Jun 2023 15:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687990071; x=1690582071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LafiJyNgbZmNNbdJGp4ZrkLO2f20OEreitolc2Mh/lo=;
        b=TWkZgtMnOjQ2BQgN2S+/6O2vnbhFjfQESF7dQ6UGtsBJcCRM3YYovEwoYR7mYnc3VI
         fNyYkGGJjmFUI3QAqvAmGW0+NfGbIR9WriPM7KyF2F8LI6vXFNPH3TTjzu20ftk+TuT1
         RiJCXYFjI2B+GkhFM76rsd6ySUdekdP65I+ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687990071; x=1690582071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LafiJyNgbZmNNbdJGp4ZrkLO2f20OEreitolc2Mh/lo=;
        b=AfgPDOByj3OlUkFs3cQDCr5oMskBS1524amNG7YMY2Feyw1sWQW+XIFtv2STtsRFSN
         zHy9g9QpG0jT5p6ScgJNTBNaIE2A0QNczPQJ5fJEmtejP+UmBb8potngt0s2eYZX9hcf
         E88mNhvnwT0t05kc2wRiC+Q+39nk3HTc3SEFXv6F4gq4hTYSLIULUScotG7wIpfsez3l
         E3BcwvO/Y8uSEB7K3tOL7AKtG5u8hoIlKWTLWkampDqlH2bN8PDfmLCj1B1Uubu5/Vfg
         644pfAsrVHaCyeDtMjwWkClfBJa7AOVhZ5g96VyEVeCPLulPjsDY8yNlUqHtAMUinte7
         PqQg==
X-Gm-Message-State: AC+VfDy/MCMa5hlolL2T+SWbE4XdOu4Wfc3Oq0tcVfnlxpVkkthAxNiy
        CTi9Oi4wV64gInVypCpxc+MRzr21rcX7hCIYcxK9bSUd
X-Google-Smtp-Source: ACHHUZ7NTkxN+rHMe3eR4HxxIfdAa5U8QQfaS70wrRdsaym+OHdpFr5XypeTtx+cZ2cjDQR8oQ+c0Q==
X-Received: by 2002:a2e:8643:0:b0:2b6:c3b8:3a9f with SMTP id i3-20020a2e8643000000b002b6c3b83a9fmr1135521ljj.29.1687990071697;
        Wed, 28 Jun 2023 15:07:51 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id j12-20020a2e800c000000b002b1d6bfab5csm2398964ljg.22.2023.06.28.15.07.50
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 15:07:51 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso50657e87.1
        for <linux-modules@vger.kernel.org>; Wed, 28 Jun 2023 15:07:50 -0700 (PDT)
X-Received: by 2002:aa7:c947:0:b0:51a:2c81:72ee with SMTP id
 h7-20020aa7c947000000b0051a2c8172eemr23606011edt.20.1687990050285; Wed, 28
 Jun 2023 15:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <ZHTCK2_1pF61yWIr@hovoldconsulting.com> <CAHk-=wg7ihygotpO9x5a6QJO5oAom9o91==L_Kx-gUHvRYuXiQ@mail.gmail.com>
 <ZHYitt7P7W+8ZlSB@bombadil.infradead.org> <499e30cc-d015-8353-1364-50d17da58f47@redhat.com>
 <ZHd8bLPY4OQCb/Z5@bombadil.infradead.org> <ba60bca6-b682-4c27-3c54-2512b6f16151@redhat.com>
 <ZHoTFDkPIgglW0sU@bombadil.infradead.org> <fa3f1a1f-edc6-f13b-cc84-f3264b03b0b1@redhat.com>
 <ZH38lpTHZ/RISC1v@bombadil.infradead.org> <ZH3/KVCHhX4D4yh9@bombadil.infradead.org>
 <ZJyBhv6yrAfYvMh5@bombadil.infradead.org> <CAHk-=wiSRTEOgiDA5qUTPGcw=Fbk9Ou2i97kfSBcj3pey3X=fQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiSRTEOgiDA5qUTPGcw=Fbk9Ou2i97kfSBcj3pey3X=fQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Jun 2023 15:07:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPz4Fj9M_h7sRSHAK9QeJiTFaYMWX3fDyZ-Bj41HftmA@mail.gmail.com>
Message-ID: <CAHk-=wgPz4Fj9M_h7sRSHAK9QeJiTFaYMWX3fDyZ-Bj41HftmA@mail.gmail.com>
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

On Wed, 28 Jun 2023 at 13:14, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In other areas, I may send out patches, but I don't feel like I'm a
> maintainer, so I then think that "the real maintainer can decide if
> these patches are good or not".

Anyway, since I clearly didn't communicate clearly that I was throwing
the patch over to you, let me go and find it and just apply it myself.

           Linus
