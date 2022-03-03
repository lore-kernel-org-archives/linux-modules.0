Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190E7C433EF
	for <linux-modules@archiver.kernel.org>; Thu,  3 Mar 2022 10:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbiCCKo4 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 3 Mar 2022 05:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiCCKo4 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 3 Mar 2022 05:44:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D81845072
        for <linux-modules@vger.kernel.org>; Thu,  3 Mar 2022 02:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646304249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JprPZetbIa3gZelRValOQCvT2YcVAHIjq5tXKGeAvvg=;
        b=ExOrXc7muzmRQ+zQ7dOUIehpFVv4AmWt5A4pQpd2nwpaFc4t1BOggVnyIGrJqLPXPHx4mC
        vq3LQV7EoFlPRpwRf/HwK/nPvifVBYZPEMk9083igLvjezJNY81tjHQJHSM9Up6qJAdbK+
        3HAgwPXoP22Qr5UsFWnO9bYHSv/EuPk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550--8F7SKMZPBS6p-5w9CbbNA-1; Thu, 03 Mar 2022 05:44:07 -0500
X-MC-Unique: -8F7SKMZPBS6p-5w9CbbNA-1
Received: by mail-wm1-f71.google.com with SMTP id v67-20020a1cac46000000b00383e71bb26fso1112441wme.1
        for <linux-modules@vger.kernel.org>; Thu, 03 Mar 2022 02:44:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JprPZetbIa3gZelRValOQCvT2YcVAHIjq5tXKGeAvvg=;
        b=hZziSTG1KTeGY7JLtq9Uq+2nkuiZqbY/gieu9JXDhcbW5F06QbNMhp7LaNXFOxDzYZ
         yckPS3yWKe+PB3ndExAMwM7Uz6giM6OAcd3lgLgybFJB1yS+QvJ2UiMNb8FyVjrVLohx
         TDzgegg8OjWS/KFG7KTOivrpy7vCySD0hkNWqXpj/f7/uRIRLyxMFcN007rPf3SZgyIt
         D8g/JQz3rdwDTfHx/cPnxJG0BuLddpnXtshXXxkg1Kbv/Bi9hHzOoVys/rS0crGclIMB
         B9fICz8a5P2IGl/tTUn6HM5lAOHz0087FKPtWVIGLdu9XvFnuPk4/2h36T7XKxW8JceO
         veOw==
X-Gm-Message-State: AOAM530yixFmg6zTMevSVoDvfXFhxbP/XXdWWP3gyLEzZv5wN3R7Nlgp
        lggXTkFw2xTZ/YoCDNVjkGnunduG3aAh26tKOBkRnU065W7ouEzTXq5XrFs/N+S46K02P4+JL6m
        okYCPxe/PBs0QiHc1PgaZomiL
X-Received: by 2002:adf:f947:0:b0:1ef:9b55:7cba with SMTP id q7-20020adff947000000b001ef9b557cbamr15963996wrr.142.1646304246605;
        Thu, 03 Mar 2022 02:44:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxh9WCQeSpc3JiAKR09PprZtkHgEaKEjwnm3cnkYiHYbMin5c3oly+30gtLp/GKtHOUsxMucg==
X-Received: by 2002:adf:f947:0:b0:1ef:9b55:7cba with SMTP id q7-20020adff947000000b001ef9b557cbamr15963983wrr.142.1646304246425;
        Thu, 03 Mar 2022 02:44:06 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id l10-20020a056000022a00b001f017dfb5cdsm2135555wrz.90.2022.03.03.02.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 02:44:05 -0800 (PST)
Date:   Thu, 3 Mar 2022 10:44:04 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
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
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>
Subject: Re: [PATCH v9 13/14] module: Move kdb_modules list out of core code
Message-ID: <20220303104404.crqt7oz4kydq36fo@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-14-atomlin@redhat.com>
 <20220302161917.gx5icfszakoye4uh@maple.lan>
 <20220302203153.3kcmwu662szf3drt@ava.usersys.com>
 <a87aac32-52b1-3d56-6331-1c241fea032f@csgroup.eu>
 <Yh/zy7FCcDmIdAn8@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yh/zy7FCcDmIdAn8@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Wed 2022-03-02 14:46 -0800, Luis Chamberlain wrote:
> Since we are doing this to help with the cleaning this crap up
> the natural thing to do is have the code be a helper which only
> built-in code can use, so writing a helper starting with
> list_for_each_entry() which prints the modules out. I'm
> surprised we have no other users of this. There is nothing
> kdb specific about the functionality in that code. So it should
> just be moved.

Hi Luis,

Good point, albeit is it really worth it since the only external
user is kernel/debug/kdb/ code?


Kind regards,

-- 
Aaron Tomlin

