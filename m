Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D006DC43334
	for <linux-modules@archiver.kernel.org>; Sun,  3 Jul 2022 14:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbiGCOWh (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 3 Jul 2022 10:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiGCOW3 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 3 Jul 2022 10:22:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86E5F2DF0
        for <linux-modules@vger.kernel.org>; Sun,  3 Jul 2022 07:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656858147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=axYsTZ/q6cjrUNl4MVAJ5gd7O1k4pTmZjnHk0JetlKs=;
        b=GM0t1Z/A3X3N0cDt9q8eUm3caj03T0vrOFTwuRAmvn+BmRy1bTwOoyjsGG/sdtOrZP94Am
        ubYBHV2NCb4HsDeT1cbFNjJD9O5m0aqavItzC7qlLD8mX+pDRoexQ1GfFirbXJQScTZ17i
        cL6ToJOjuHCZDsBD0DMhofnRbIUguDo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-YbRWzQLBOd-elxBAvB09qw-1; Sun, 03 Jul 2022 10:22:21 -0400
X-MC-Unique: YbRWzQLBOd-elxBAvB09qw-1
Received: by mail-wm1-f71.google.com with SMTP id h125-20020a1c2183000000b003a0374f1eb8so5967875wmh.8
        for <linux-modules@vger.kernel.org>; Sun, 03 Jul 2022 07:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=axYsTZ/q6cjrUNl4MVAJ5gd7O1k4pTmZjnHk0JetlKs=;
        b=iG/uo4D8xuUQLl4h7khcZNaPFAPB+B1ScibiUV7GvitvCCduC5a/I5+uNaIDoidMJd
         AoT1DylEfoqGBSbpfWDn+JWWyOIHJLol54clKst//51kVUOqML4kMFQobY/5Qy5+ABoy
         juMpTd2+xDt7Jpibkdv26q9vL6CgtuAUvVvj6wFAtDxjYWsWl4SpYwfdniqVjsBvUXhh
         0yLFeny5fmGhYpB3S9GWVFyaIWHx5AMJdOCJddlOC6OzttR9jhr1iyl1pW/8Y+vO8ZQV
         QhT58RA4uFeZ14lNMwJkMmvcC4oWulbQ0HA8TI+d6QqF6pC1M4wMiSDz+4BYU33oZWM2
         Xhlw==
X-Gm-Message-State: AJIora9xPUmMtMHzGuJdTA49O6wNQ1kj1XZjUGADBbI8K4PtawkovDF/
        2tKiO6b2ocj7GGCURv8u1e5XZtA6iRt+Sa1/PP/bCq97pzkqLRMmcAGs7o21RRJpm4JQOmD2UHZ
        HzOr8yeCOD7TyzP35YrC7v2zi
X-Received: by 2002:a05:600c:3788:b0:3a0:4279:5142 with SMTP id o8-20020a05600c378800b003a042795142mr24555754wmr.21.1656858140324;
        Sun, 03 Jul 2022 07:22:20 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sN/HF29rpcpC+6ICiQIsHeqb5vPV1E0KQ13hXXngqkdM+5+G0r9snt2h/T0duAn6byx8Hpsw==
X-Received: by 2002:a05:600c:3788:b0:3a0:4279:5142 with SMTP id o8-20020a05600c378800b003a042795142mr24555744wmr.21.1656858140117;
        Sun, 03 Jul 2022 07:22:20 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id g13-20020adffc8d000000b0021b99efceb6sm27846574wrr.22.2022.07.03.07.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 07:22:19 -0700 (PDT)
Date:   Sun, 3 Jul 2022 15:22:18 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] module: Show the last unloaded module's taint flag(s)
Message-ID: <20220703142218.65dacvxozppgct6y@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220627164052.2416485-1-atomlin@redhat.com>
 <20220627164052.2416485-2-atomlin@redhat.com>
 <4ddb64da-58f0-a4af-cf57-a870015a0077@csgroup.eu>
 <20220628074708.fg3ocx3vu7affkxl@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220628074708.fg3ocx3vu7affkxl@ava.usersys.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue 2022-06-28 08:47 +0100, Aaron Tomlin wrote:
> On Tue 2022-06-28 05:54 +0000, Christophe Leroy wrote:
> > > -	/* Store the name of the last unloaded module for diagnostic purposes */
> > >   	strlcpy(last_unloaded_module, mod->name, sizeof(last_unloaded_module));
> > > +	strcat(last_unloaded_module, module_flags(mod, buf, false));
> > 
> > You replace a bounded string copy by an unbounded strict contat.
> > 
> > Should you use strlcat() instead ?
> 
> Hi Christophe,
> 
> Why? If I understand correctly, both the destination and source string are
> NULL-terminated (see module_flags()). So, strcat() should be sufficient.

Hi Luis,

Any thoughts on this? As far as I can tell, the destination string cannot
be overwritten; albeit, I can use the safer option if you prefer.


Kind regards,

-- 
Aaron Tomlin

