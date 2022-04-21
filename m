Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC09C433EF
	for <linux-modules@archiver.kernel.org>; Thu, 21 Apr 2022 14:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384860AbiDUPBD (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 21 Apr 2022 11:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389810AbiDUPA4 (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 21 Apr 2022 11:00:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7376B45521
        for <linux-modules@vger.kernel.org>; Thu, 21 Apr 2022 07:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650553081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QTpLm3aOQpkfLEJJjDuQKbkph6dKXan/c9US+6RE4vQ=;
        b=HM/gHC2t6TLK8NFf9iD8wULNZIKIDgYmjcfBKytdOa9omB+BJTOpAMTY2Qbijv3XjwCaQk
        vw0OqBkN0B8okUJyPWlebn6hm+jJMaL7F9KM9iBPsupNp7fpeWXxud2TblUnN7Km0nEFhE
        yZajq7o9+67rwx6EBP3lDkTc1w3yT2k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-UjgYZrdGN8GshxI2CNfOvg-1; Thu, 21 Apr 2022 10:58:00 -0400
X-MC-Unique: UjgYZrdGN8GshxI2CNfOvg-1
Received: by mail-wm1-f72.google.com with SMTP id az27-20020a05600c601b00b0038ff021c8a4so4611872wmb.1
        for <linux-modules@vger.kernel.org>; Thu, 21 Apr 2022 07:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QTpLm3aOQpkfLEJJjDuQKbkph6dKXan/c9US+6RE4vQ=;
        b=RhMkZgnIraiaGMpOkBEK5Thi2CbWtse96sJpn9nH/gpDrUXA6e5b2dtG2QKMAFMca8
         nUGNvGrFMIF47OrCdCQ3Ud+femAfHGhYst3g2uI2WhgppKy5whYSNUYo0gP3SZ12Ptas
         zauCq86KD2+vCp/lfAb+4cR3dULel79StndLjNTbmg6DuliuHohx/8koESV3YYspaO0/
         QwdWJN9KY0LNE2d/urVKjIEw4iSBLDOnZfXmr022qN4zAgg2WaX37j7cDV/e1mIvED6H
         og3USztn5ijoyV5AMh+nDmelNsfb4TE1CcpdqjDM3cyzt69N2U7cC5SmijyPgaXKnZ7s
         L7wA==
X-Gm-Message-State: AOAM532sqhEZX1ULbcO+40BogA56s5ZmDWhgIRbdXK5FfuNqo/G0rcMV
        6MaEIy8EhhoZiIZW8wFsqWpxKrKiGhPQbnqq7CerYMEDEN0MT2sVpnjpLeRWKcKp6dvHJnK701G
        VE2kXCJwLTbGgHiyJDX5GosQ0
X-Received: by 2002:a05:6000:18d0:b0:209:199b:77bd with SMTP id w16-20020a05600018d000b00209199b77bdmr79868wrq.537.1650553079257;
        Thu, 21 Apr 2022 07:57:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJ87QB6k4nsC8/Q8oHNWMq7K56KzTtSPg+WKsCl+jH76+ULd8++Qqa+PoYjSWc0h/Ay72faQ==
X-Received: by 2002:a05:6000:18d0:b0:209:199b:77bd with SMTP id w16-20020a05600018d000b00209199b77bdmr79847wrq.537.1650553079060;
        Thu, 21 Apr 2022 07:57:59 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id p3-20020adfaa03000000b00207a1db96cfsm2558786wrd.71.2022.04.21.07.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:57:58 -0700 (PDT)
Date:   Thu, 21 Apr 2022 15:57:57 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     mcgrof@kernel.org, cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        christophe.leroy@csgroup.eu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, neelx@redhat.com
Subject: Re: [PATCH v3 2/2] module: Introduce module unload taint tracking
Message-ID: <20220421145757.zfn6zxh6rx3dp75o@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220420115257.3498300-1-atomlin@redhat.com>
 <20220420115257.3498300-3-atomlin@redhat.com>
 <2100545.irdbgypaU6@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2100545.irdbgypaU6@natalenko.name>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu 2022-04-21 16:28 +0200, Oleksandr Natalenko wrote:
> Hello.

Hi Oleksandr,

> Thanks for this submission. Please see one comment inline.

Thanks for your feedback!

> > @@ -150,6 +160,41 @@ int unregister_module_notifier(struct notifier_block *nb)
> >  }
> >  EXPORT_SYMBOL(unregister_module_notifier);
> >  
> > +#ifdef CONFIG_MODULE_UNLOAD_TAINT_TRACKING
> > +static int try_add_tainted_module(struct module *mod)
> > +{
> > +	struct mod_unload_taint *mod_taint;
> > +
> > +	module_assert_mutex_or_preempt();
> > +
> > +	list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules, list,
> > +				lockdep_is_held(&module_mutex)) {
> > +		size_t len = strlen(mod_taint->name);
> > +
> > +		if (len == strlen(mod->name) && !memcmp(mod_taint->name, mod->name, len) &&
> 
> Here, two strings are compared, so I'd expect to see `strncmp()` instead of `memcmp()`.

Good point. There are other examples of this throughout
kernel/module/main.c; albeit, I will use strncmp() here.


Kind regards,

-- 
Aaron Tomlin

