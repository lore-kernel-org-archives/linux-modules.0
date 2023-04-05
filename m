Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA09BC76188
	for <linux-modules@archiver.kernel.org>; Wed,  5 Apr 2023 16:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjDEQaz (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 5 Apr 2023 12:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjDEQay (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 5 Apr 2023 12:30:54 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503C0173E
        for <linux-modules@vger.kernel.org>; Wed,  5 Apr 2023 09:30:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id fi11so19023762edb.10
        for <linux-modules@vger.kernel.org>; Wed, 05 Apr 2023 09:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680712249; x=1683304249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQpmkrukxD+353BntikJkYNT/bA711Va7HsLI05KtRc=;
        b=JDgkcIzzvftmuHcDQbzon2qTAfYQNaKL7ZU42yrPBcEAdPMncDYyYd8cQObyHUf+a7
         cNNbYQqnHnhZ4BQ0GQbaDld1sLbIkXj+1fNfV/Y5UID/+VoFoQcnQovsijwO54ub9RN+
         mBq+IpJgQDNboouQUJ+bsvJ8GeEvqRxhCmTr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680712249; x=1683304249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQpmkrukxD+353BntikJkYNT/bA711Va7HsLI05KtRc=;
        b=1RzuggBVa5TexPRh/roxfATVaSfX7u9ZyNmKdmFW8dcL5tEZzTFNdA+Q9ApCvWw51x
         H9YS8/3WFV0z2Gqj0n9b1OEbTeioa0ppv4+lLgqavwQ8IDFD6tODWXoMJwwo/qo6sIyY
         Fu9dzmtvHS/eqskigyDnmR2i8gcGdDD2HUR22CSHLGbIJSTnYrl7usJ4VW+WbPeM0AeN
         qpBv0cVxILibMV6st1raiGC7JuYGv0zHnrLTc3W3054Fb8MTKGaG8u8s0Nq+NT5KUXiu
         JfwykqgDT/Ff/jNFXQD4xZzhDaxXw/zLvBcq9xg4zEHeTmVTaOJDx0t4O8eQSaV16QHG
         F33w==
X-Gm-Message-State: AAQBX9eRmi6LSrws/qXEbOJsHvqUNutB7801S5ktbvCFormC1Ono0O1s
        fx/buJjaMqsmuxc0WbcSpxQdfP1y2k9+bNs0Xp6hgA==
X-Google-Smtp-Source: AKy350aNNhgpJZNa0yujEja2BeFStigy4N8xDjqgRCbR3J/ZoRNpkcB+rHwIEP897O9k7pgGztsmEQ==
X-Received: by 2002:a17:906:7191:b0:8b1:2d0e:281 with SMTP id h17-20020a170906719100b008b12d0e0281mr3542254ejk.18.1680712249398;
        Wed, 05 Apr 2023 09:30:49 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id kd24-20020a17090798d800b00933d64cd447sm7515241ejc.121.2023.04.05.09.30.49
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 09:30:49 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-50263dfe37dso2951304a12.0
        for <linux-modules@vger.kernel.org>; Wed, 05 Apr 2023 09:30:49 -0700 (PDT)
X-Received: by 2002:a17:906:7e05:b0:932:da0d:9375 with SMTP id
 e5-20020a1709067e0500b00932da0d9375mr1892812ejr.4.1680711806400; Wed, 05 Apr
 2023 09:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230405022702.753323-1-mcgrof@kernel.org> <20230405022702.753323-6-mcgrof@kernel.org>
 <CAHk-=whH+OsAY+9qLc9Hz+-W8u=dvD3NLWHemOQpZPcgZa52fA@mail.gmail.com>
 <ZC2cC+I1KTyD8UcC@bombadil.infradead.org> <ZC2dtI02ZIbjte2l@bombadil.infradead.org>
In-Reply-To: <ZC2dtI02ZIbjte2l@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Apr 2023 09:23:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGhHk4u2RRZmJinA4Apb47pXXJPW9cOZ_2-yUqOvaC7Q@mail.gmail.com>
Message-ID: <CAHk-=wiGhHk4u2RRZmJinA4Apb47pXXJPW9cOZ_2-yUqOvaC7Q@mail.gmail.com>
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

On Wed, Apr 5, 2023 at 9:11=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>
> Oh but I don't get the atomic incs, so we'd need debugfs_create_atomic_lo=
ng_t().

No, you misunderstand what I meant.

Just use "atomic_long_t" in the module code.

But then the debugfs code should do

        debugfs_create_ulong(... &val->counter ..);

to expose said atomic_long values.

No need for new debugfs interfaces.

Because "atomic_long" is just a regular "long" as far as plain
read/set operations are concerned - which is all that the debugfs code
does anyway.

So I think you can do something like

  atomic_long_t total_mod_size;

   ...

  debugfs_create_ulong("total_mod_size",
       0400, mod_debugfs_root,
       &total_mod_size.counter);

but I didn't actually try to compile that kind of version.

(I think "counter" is actually a _signed_ long, so maybe the types don't ma=
tch).

               Linus
