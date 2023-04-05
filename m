Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3D7C76188
	for <linux-modules@archiver.kernel.org>; Wed,  5 Apr 2023 15:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbjDEP0p (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 5 Apr 2023 11:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbjDEP0n (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 5 Apr 2023 11:26:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF8C4C31
        for <linux-modules@vger.kernel.org>; Wed,  5 Apr 2023 08:26:40 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ew6so141929329edb.7
        for <linux-modules@vger.kernel.org>; Wed, 05 Apr 2023 08:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680708398; x=1683300398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiNSMmn4P5V1jwJhNPZuiJRsbJQ57AhnJVTBbX8pgZo=;
        b=NSoOjhoaVJ30e5PphrSukeB/G2v7DuMPOO2t5SabWWaGhavl0xfhxz0DYH8NUGuXbq
         iMT3QA4D9glPde1jx+NRYc8+RO/WQk6HfomFOrKRPVeweDhkiix+sLVAHAWS3c75EQud
         OcT5h++l1ropGhkanYmM5XQ20yzWKHMTFH0CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680708398; x=1683300398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiNSMmn4P5V1jwJhNPZuiJRsbJQ57AhnJVTBbX8pgZo=;
        b=Do2OXB/ubrbMw0dnp19tiDozuHscSHrYF2hg7axi8fOJy4cP80jDiVTWXiJwbkLs4A
         //bIMqsJGQZDLbTrHNjtpViFDxYaCO/vq37DW96Eo+FSTEtHGJ/4BHs6JekQT7HWZK7C
         08LlPn0mTRSpUmYk02inb4BVEuPDE0k14HBdXaKLKvTIniZsJUG49518T2TL5U2KIriq
         VoUWZMBlUztXUETi/4/+go7+FmMCbUt6W/6fm8j6ImwBrSQKR97JEKZiZKMONt5v40Wy
         AyodYdF920OIkFI3y0Oqc69F3OPQWfHgELc/ulKxjrlMKdt872nSBB5s0/HfkhVKjiRH
         VOnw==
X-Gm-Message-State: AAQBX9dj50dseCzxgBtfhrbn42Tp5aXvcoQfoVoWVVq24P3jeV100wi/
        w+4o8aVvs7jSktcogp0sZ3doiiEwPjp6ZYaoUWxMlA==
X-Google-Smtp-Source: AKy350a/S1vy04+YbfTF2W6iTF/EHMabrHSy6f8Xg/AqwMHooxZvubHmsqF7eqMfq6btAvQAjcdZaQ==
X-Received: by 2002:a17:906:94d7:b0:92b:846d:8928 with SMTP id d23-20020a17090694d700b0092b846d8928mr3067903ejy.65.1680708398439;
        Wed, 05 Apr 2023 08:26:38 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id u1-20020a170906950100b00939faf4be97sm7473774ejx.215.2023.04.05.08.26.36
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 08:26:37 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id r11so142052730edd.5
        for <linux-modules@vger.kernel.org>; Wed, 05 Apr 2023 08:26:36 -0700 (PDT)
X-Received: by 2002:a17:907:2075:b0:947:72cd:9325 with SMTP id
 qp21-20020a170907207500b0094772cd9325mr1890350ejb.15.1680708395703; Wed, 05
 Apr 2023 08:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230405022702.753323-1-mcgrof@kernel.org> <20230405022702.753323-6-mcgrof@kernel.org>
In-Reply-To: <20230405022702.753323-6-mcgrof@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Apr 2023 08:26:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=whH+OsAY+9qLc9Hz+-W8u=dvD3NLWHemOQpZPcgZa52fA@mail.gmail.com>
Message-ID: <CAHk-=whH+OsAY+9qLc9Hz+-W8u=dvD3NLWHemOQpZPcgZa52fA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] debugfs: add debugfs_create_atomic64_t for atomic64_t
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, Apr 4, 2023 at 7:27=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> Sometimes you want to add debugfs entries for atomic counters which
> can be pretty large using atomic64_t. Add support for these.

So I realize why you use atomic64, but I really suspect you'd be
better off with just the regular "atomic_long".

This is not some debug stat that we care deeply about on 32-bit, and
"atomic64" is often really really nasty on 32-bit architectures.

For example, on x86, instead of being a single instruction, it ends up
being a cmpxchg loop. In fact, even a single atomic read is a cmpxchg
(admittedly without the need for looping).

And yeah, I realize that we don't have a "atomic_long" debugfs
interface either. But I think we could just use atomic_long for the
module code (avoiding all the horrors of 64-bit atomics on 32-bit
architectures), and then using just 'var->counter' for the value. It's
not like the debugfs stuff actually does any truly atomic updates.

So something like

        debugfs_create_ulong(... &val->counter ..);

instead of

        debugfs_create_atomic64(... &val ..);

Hmm?

I dunno. I just think this is not something that may be worth
introducing a new thing for, when it is *so* painful on 32-bit, and
doesn't seem worth it.

                   Linus
