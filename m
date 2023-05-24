Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDF9C77B7C
	for <linux-modules@archiver.kernel.org>; Wed, 24 May 2023 21:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbjEXVxN (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 24 May 2023 17:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjEXVxM (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 24 May 2023 17:53:12 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5027912E
        for <linux-modules@vger.kernel.org>; Wed, 24 May 2023 14:53:10 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-970028cfb6cso268953766b.1
        for <linux-modules@vger.kernel.org>; Wed, 24 May 2023 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684965188; x=1687557188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmM3xzgdi9y49uPixr7wck0B/tHNIYgDgFJoqWzjkEA=;
        b=bVqxREpK+03YND31Jh4cEDFPgL8FpJW9NnFeb5mMkzhklvbtJwbW1wbr9S5aL3GkJy
         Q6jN5x7OX/eP3Vgzcn4H7I7rJd6gqAcvyDKnnba9AaTQLQy8xlESHq9txuYPGC922HHS
         LaTgptjCKBFG1TmYlmHJcUMn2OfDQnw8+DJRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684965188; x=1687557188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GmM3xzgdi9y49uPixr7wck0B/tHNIYgDgFJoqWzjkEA=;
        b=Y4U/ZN69LvpbX3beQE7VbOjvpDihMUQXaGSYmzTtlHp6J81JSIpYtNGGVrzGwUGgxN
         7Z8jlIw2M1MBXuYVYBls3/1GZNayLZJTOpcyqcvDMgNzdMBoUKuqwiDi719tD6xPPg6U
         5S2VJdsDtpyOVmauPJ1zPN276sMRcrFSWRMXX/YbUN78Df8il8OCzbKGHNClSE5cc2zi
         O0BCH30BJ5WkXWSi/bNPmnRedCSWrMa62OUD7A+ojutdRcoT9Bg/tTTmfsCU5mQg1sKJ
         10Joq8q1p/AVkBIrUsPoWUaUEDhcc4lMSGdyBKq9utWA0QbPuw31PwZK1Lf+pZ81u1t3
         1Mzw==
X-Gm-Message-State: AC+VfDy+O+Mw2SOQESCD+v7rkJG37QSZj1Gb5IjWDCWBuonWfHnhs+1k
        eiQFLIjAGgcUBFBZquMmgo1O1x+iw33b256KdUY9qL13
X-Google-Smtp-Source: ACHHUZ6X7QUyJ9I5u+sTSXO3lLRkxde3LddoddQX1NLp3Lzu84BQxg8NLzKi/yO8dlzTE3RtrTfp8w==
X-Received: by 2002:a17:906:fe45:b0:96a:58a:6cd8 with SMTP id wz5-20020a170906fe4500b0096a058a6cd8mr16717851ejb.9.1684965188690;
        Wed, 24 May 2023 14:53:08 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id n18-20020a1709065e1200b0096629607bb2sm6251189eju.98.2023.05.24.14.53.07
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 14:53:07 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-513fea21228so3038369a12.3
        for <linux-modules@vger.kernel.org>; Wed, 24 May 2023 14:53:07 -0700 (PDT)
X-Received: by 2002:a17:907:8a12:b0:93e:fa12:aa1a with SMTP id
 sc18-20020a1709078a1200b0093efa12aa1amr19427794ejc.1.1684965187067; Wed, 24
 May 2023 14:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230524213620.3509138-1-mcgrof@kernel.org> <20230524213620.3509138-2-mcgrof@kernel.org>
In-Reply-To: <20230524213620.3509138-2-mcgrof@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 May 2023 14:52:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjahcAqLYm0ijcAVcPcQAz-UUuJ3Ubx4GzP_SJAupf=qQ@mail.gmail.com>
Message-ID: <CAHk-=wjahcAqLYm0ijcAVcPcQAz-UUuJ3Ubx4GzP_SJAupf=qQ@mail.gmail.com>
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

On Wed, May 24, 2023 at 2:36=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.org=
> wrote:
>
> Add support for a new call which allows to detect duplicate requests
> for each inode passed.

No.

This is all disgusting.

Stop adding horrific code for some made-up load that isn't real.

           Linus
