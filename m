Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41913ECAAD1
	for <linux-modules@archiver.kernel.org>; Wed, 31 Aug 2022 10:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiHaKTP (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 31 Aug 2022 06:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHaKTN (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 31 Aug 2022 06:19:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A0749B76
        for <linux-modules@vger.kernel.org>; Wed, 31 Aug 2022 03:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661941152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZpRLTT1itQwP+u94Lmsh32laOgKQktQ3e6PuJ0p2Rms=;
        b=YG46NREptaJz/FegmIQTc9Dku7vF+84g6SdlHDFVBviQZPZo+ZvkYi9uU3omuZ47g7cpd3
        t+fd4VOKsX0nOvQJg+N53GUzd380IU3mJZsZPyaIHCfwKs3Kx0IjbFTBOYYzsskaH0j1NC
        DWDcsR1Kzol5GIWyxOBu6f9D8CJqVRw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-379-X2ZHv0PiNSSY6gGXFoy8Eg-1; Wed, 31 Aug 2022 06:19:10 -0400
X-MC-Unique: X2ZHv0PiNSSY6gGXFoy8Eg-1
Received: by mail-wm1-f70.google.com with SMTP id c64-20020a1c3543000000b003a61987ffb3so8082788wma.6
        for <linux-modules@vger.kernel.org>; Wed, 31 Aug 2022 03:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ZpRLTT1itQwP+u94Lmsh32laOgKQktQ3e6PuJ0p2Rms=;
        b=DWmv5xbPg5AQEEeKcJ1rjht8wipM8ytgmBZMS5/9F9367SpRJjJr+ljYohJF+Wc3Mx
         uRszj6LZx8r3/pZ/mJb/FRgcSvTgVZPAdNfE2Jan0zCWn/QVn5ARtQDsUx4c+Bhol322
         B4hNLJM60XXfmAT7eGkMmrhfenxJ8byZ8xvSmE9ghhVG2RqibkYKAetGSV6nMbPMy6yc
         bpY9e29kZnlz8dOeCfl6IhpeDDOJxLvTt0Fx4rl4byA05X8LdrrrIMGURBX01KqXxClb
         YPV+tTq1PKhVTmfdQqd6gNopvsN0U8iacxlYkoDusBsZ1KoloTj4silPSP7tHaE92I4r
         GPIg==
X-Gm-Message-State: ACgBeo3cumQep+d/FUreFCFVHTVwaITAS/gtoHd0lMBYau//rRdnxvHn
        3uajoKgyhvIvnBby4eUaZLfmEv5/DFLy+pQxd7/j3MsaMNX3te/L89zlV2DXsSVLoFO2QbHUFV9
        oaOwQ/1aLfhzjtmB1VNM6pxqW
X-Received: by 2002:a7b:c5c3:0:b0:3a6:14f3:8ea7 with SMTP id n3-20020a7bc5c3000000b003a614f38ea7mr1465431wmk.76.1661941149694;
        Wed, 31 Aug 2022 03:19:09 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7PA9SH0oxj5GA6arasN/HeWr1ySDu7wDrfw96TfFaP41YwtAWjTM8Fq70mv1aAeWH9rphx4g==
X-Received: by 2002:a7b:c5c3:0:b0:3a6:14f3:8ea7 with SMTP id n3-20020a7bc5c3000000b003a614f38ea7mr1465421wmk.76.1661941149506;
        Wed, 31 Aug 2022 03:19:09 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id e14-20020adfef0e000000b0021d6924b777sm7186178wro.115.2022.08.31.03.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 03:19:08 -0700 (PDT)
Date:   Wed, 31 Aug 2022 11:19:07 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     mcgrof@kernel.org, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com
Subject: Re: [PATCH modules-next] module: Add debugfs interface to view
 unloaded tainted modules
Message-ID: <20220831101907.5rqz6ylj2dyojqnj@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220823193225.2072649-1-atomlin@redhat.com>
 <2bf2b4ee-fd8d-962d-0daa-9c8093ad331e@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2bf2b4ee-fd8d-962d-0daa-9c8093ad331e@suse.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon 2022-08-29 09:14 +0200, Petr Pavlu wrote:
> On 8/23/22 21:32, Aaron Tomlin wrote:
> > [...]
> > @@ -59,3 +60,68 @@ void print_unloaded_tainted_modules(void)
> >  		}
> >  	}
> >  }
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +static void *unloaded_tainted_modules_seq_start(struct seq_file *m, loff_t *pos)
> > +{
> > +	mutex_lock(&module_mutex);
> > +	return seq_list_start_rcu(&unloaded_tainted_modules, *pos);
> > +}

Hi Petr,

> unloaded_tainted_modules looks to be a proper RCU list which makes me think
> this reader could use just rcu_read_lock() instead of
> mutex_lock(&module_mutex)?

If I understand correctly, yes: the use of rcu_read_lock() and
rcu_read_unlock(), respectively, will be sufficient.

I will send a follow up patch.


Kind regards,

-- 
Aaron Tomlin

