Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D1EC433EF
	for <linux-modules@archiver.kernel.org>; Fri, 25 Feb 2022 12:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbiBYMWp (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 25 Feb 2022 07:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240212AbiBYMWn (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 25 Feb 2022 07:22:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D0301BA910
        for <linux-modules@vger.kernel.org>; Fri, 25 Feb 2022 04:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645791730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VHio/1j2ziq08MzsSjFM5LunsRNcq2NGF4pX47OZdHs=;
        b=fS8jEFRTuk3ASOZFPA+nE6QD21rBzAuVBumzkxegbyUBOpTd0jSHKe9wUH63RHCZagx91U
        hdpXrUzLH7Wz+G4ipA57yhqXk9CZFzUKnxgi1+jbGY9Opr7UWsyQ4Uzhe+pRI8z5wC+aPy
        HAVXm8XV60iqKOE9kbrEQJziqkJszX8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-622LD-W2PtOzgW7epU9paQ-1; Fri, 25 Feb 2022 07:22:09 -0500
X-MC-Unique: 622LD-W2PtOzgW7epU9paQ-1
Received: by mail-lf1-f71.google.com with SMTP id e8-20020ac25468000000b00443973fc878so956363lfn.23
        for <linux-modules@vger.kernel.org>; Fri, 25 Feb 2022 04:22:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHio/1j2ziq08MzsSjFM5LunsRNcq2NGF4pX47OZdHs=;
        b=L3WHP+ltplMxHZonDb7OzO2F1dSpyoQ6dgiHUwTRveJKfz8S1hSS3gZ5dM5YlUhsfQ
         ffH8Ba+A2d92k1C9idoIcYb8iOsmSm8HjI4MfVQMhHDR64raxGD/02s95GlcJ6FIhdnl
         IAn6Sx14lgueMVQOd4Wx9P2kqNGiXvEvql+fukxSR7GXrQOEI8LY1fQCq+N8Hj4ww+Tz
         nrA+H43//+64IoSUq3LnNsMIuHspul5gAkoXsSSJK3v4CoV3cMph9MisfzxQ5MMu9I9z
         NEBUdh8xKCZbq9vfNGire6CGgVhJ1UUk3q7JiqvEeJGpHwLGCM/d1eFyCGeYXq3EDQQD
         JC0Q==
X-Gm-Message-State: AOAM530CMZkIEca3oSEFLQW4vBinkzP6KnkcSLe+C+84m0b9m3dIqCIk
        4JZUEp/czCvWYS0O5VpxlRkgLcUg1T8ag8LZ9onIm4ufBQO5tiyJTHNAEiiJNiLlBeHuf20QyCb
        mr+/fauj+qm2lCiUr1Er6NJPYUAlwMXaJoHQD3sFk
X-Received: by 2002:a2e:b16e:0:b0:244:d368:57e with SMTP id a14-20020a2eb16e000000b00244d368057emr5187116ljm.251.1645791727687;
        Fri, 25 Feb 2022 04:22:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3HvejCFFVDV/Is5Nh4FGZXaP/OD9uoaM1fdabwy6Q5yZ3jWKafxfzdgQGsMk5Ag8w8Nh80L8EiCcBY327m4E=
X-Received: by 2002:a2e:b16e:0:b0:244:d368:57e with SMTP id
 a14-20020a2eb16e000000b00244d368057emr5187099ljm.251.1645791727486; Fri, 25
 Feb 2022 04:22:07 -0800 (PST)
MIME-Version: 1.0
References: <20220222141303.1392190-1-atomlin@redhat.com> <20220222141303.1392190-10-atomlin@redhat.com>
 <YhieKf9EcS3GQSXG@alley> <f9449aa6-be9d-9021-66e7-fb0272909ee7@csgroup.eu>
 <YhisWkgZCK8dz5fl@alley> <CANfR36gsRw26C3M0hXGGK2w_05pC0rzkhg0-3Q+8tr_XxLiqiw@mail.gmail.com>
In-Reply-To: <CANfR36gsRw26C3M0hXGGK2w_05pC0rzkhg0-3Q+8tr_XxLiqiw@mail.gmail.com>
From:   Aaron Tomlin <atomlin@redhat.com>
Date:   Fri, 25 Feb 2022 12:21:56 +0000
Message-ID: <CANfR36iKJ6pHU5gm3HKqTPZ=FGsC5qX316UKt2sN0aMFEODA9w@mail.gmail.com>
Subject: Re: [PATCH v8 09/13] module: Move kallsyms support into a separate file
To:     "mcgrof@kernel.org" <mcgrof@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri 2022-02-25 10:27 +0000, Aaron Tomlin wrote:
> On Fri 2022-02-25 11:15 +0100, Petr Mladek wrote:
> > rcu_dereference_sched() makes sparse happy. But lockdep complains
> > because the _rcu pointer is not accessed under:
> >
> >     rcu_read_lock_sched();
> >     rcu_read_unlock_sched();
>
> Hi Petr,
>
> >
> > This is not the case here. Note that module_mutex does not
> > disable preemtion.
> >
> > Now, the code is safe. The RCU access makes sure that "mod"
> > can't be freed in the meantime:
> >
> >    + add_kallsyms() is called by the module loaded when the module
> >      is being loaded. It could not get removed in parallel
> >      by definition.
> >
> >    + module_kallsyms_on_each_symbol() takes module_mutex.
> >      It means that the module could not get removed.
>
> Indeed, which is why I did not use rcu_read_lock_sched() and
> rcu_read_unlock_sched() with rcu_dereference_sched(). That being said, I
> should have mentioned this in the commit message.
>
> > IMHO, we have two possibilities here:
> >
> >    + Make sparse and lockdep happy by using rcu_dereference_sched()
> >      and calling the code under rcu_read_lock_sched().
> >
> >    + Cast (struct mod_kallsyms *)mod->kallsyms when accessing
> >      the value.
>
> I prefer the first option.
>
> > I do not have strong preference. I am fine with both.
> >
> > Anyway, such a fix should be done in a separate patch!
>
> Agreed.

Luis,

If I understand correctly, it might be cleaner to resolve the above in two
separate patches for a v9 i.e. a) address the sparse and lockdep feedback
and b) refactor the code, before the latest version [1] is merged into
module-next. I assume the previous iteration will be reverted first?

Please let me know your thoughts

[1]: https://lore.kernel.org/all/20220222141303.1392190-1-atomlin@redhat.com/


Kind regards,

-- 
Aaron Tomlin

