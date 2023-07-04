Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F81FEB64D9
	for <linux-modules@archiver.kernel.org>; Tue,  4 Jul 2023 18:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjGDSib (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 4 Jul 2023 14:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjGDSia (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 4 Jul 2023 14:38:30 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E57C10D9
        for <linux-modules@vger.kernel.org>; Tue,  4 Jul 2023 11:38:29 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b6f9edac8dso12869661fa.3
        for <linux-modules@vger.kernel.org>; Tue, 04 Jul 2023 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688495907; x=1691087907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2tbOa3HOuqGGgU4rs5MkZrWcvHhQ5c0R0nrmNFDBEYQ=;
        b=CuJmiTGpQLrfPguYpOYJGGWVpXx2Lbrw35v1dmEVrC2Ys3MnrKprS+rJWiRVVJ19M1
         tDd0AnXjf9w/rBEcnXa0fqL6hfQtzLeHe7F5rE9flxe4YRh35bRQ8YjC+6GhgLvK8m7K
         KCaJ3zyH0w0rJq5nkjhsu4psa2e6O7JhboEsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688495907; x=1691087907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2tbOa3HOuqGGgU4rs5MkZrWcvHhQ5c0R0nrmNFDBEYQ=;
        b=Nec0HXHnKCVzkkzt0WF/nwliFg1iRJwLMhdsMd5jeFooikzno0aFSvBtbyUQ+aiTcE
         W3PbPqxpC4EDaSd8X33f4Fx9iTkMCjOP6W7QW/CbNwiGdXEKcAjPnEaIqupOIdPAgFcL
         FWGABkUPPQaFki0tnm9tvvufGJQsMwLkAoeD4oli+IwjJl8r1l3f4qs6RxhmYxm3X6/b
         VJP9yKsAF4qlfvsiGdhUlCxFfG5GbHfMu188tpjrYsBqNtnSD2KrirZ0u6/bWA6HF47n
         0RLx22Cy00HKQr7QKtD3TADfZSftt0XilIFhywVu9V0M0aGednYYu48vx98HbD4th6Sj
         voJg==
X-Gm-Message-State: ABy/qLYYEFy/KqAqZiTIj+3oW/uUC6hpNySMdMWKWWqDym+LcNMAiw7p
        TeOA0LhSL9tRgDfikWb0h6TyNu/d6bM3AQ7Q7st5KA==
X-Google-Smtp-Source: APBJJlEAen4Y495v0H2c/57PrErT9quhwNqKMuB2o30w6ZufQdoqsKkSiRZDDlxTSW5i1DCFqwE9uw==
X-Received: by 2002:a05:6512:3494:b0:4f8:65ef:afcd with SMTP id v20-20020a056512349400b004f865efafcdmr8580292lfr.17.1688495907334;
        Tue, 04 Jul 2023 11:38:27 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id d10-20020a056402078a00b0051de38eb925sm6719077edy.93.2023.07.04.11.38.26
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 11:38:26 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so6683691a12.0
        for <linux-modules@vger.kernel.org>; Tue, 04 Jul 2023 11:38:26 -0700 (PDT)
X-Received: by 2002:aa7:c997:0:b0:51e:ec0:fd84 with SMTP id
 c23-20020aa7c997000000b0051e0ec0fd84mr4865749edt.40.1688495906091; Tue, 04
 Jul 2023 11:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230704092309.22669-1-vegard.nossum@oracle.com>
 <20230704100852.23452-1-vegard.nossum@oracle.com> <CAHk-=wgy2q9viwq-bAqaq8X_WQHNqDsu1AzfeYXAcDQRZmCoAw@mail.gmail.com>
 <4650691f-a025-0a93-33ec-a99ff0ede157@oracle.com>
In-Reply-To: <4650691f-a025-0a93-33ec-a99ff0ede157@oracle.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jul 2023 11:38:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=whXPYCgXXMpXxK7BGhRY3DzPk9M=t0Njshr06GsuqeXEQ@mail.gmail.com>
Message-ID: <CAHk-=whXPYCgXXMpXxK7BGhRY3DzPk9M=t0Njshr06GsuqeXEQ@mail.gmail.com>
Subject: Re: [PATCH] module: always complete idempotent loads
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        syzbot+9c2bdc9d24e4a7abe741@syzkaller.appspotmail.com,
        Johan Hovold <johan@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Rudi Heitbaum <rudi@heitbaum.com>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue, 4 Jul 2023 at 11:29, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> It's likely you already changed this with the f_mode changes I commented
> on, so maybe it's no longer a problem, though.

Yes I did. Let me just push out the stuff I have pending, including
that fixed-up commit.

[ Short time passes ]

Done.

                Linus
