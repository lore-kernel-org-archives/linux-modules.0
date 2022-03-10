Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBADC43217
	for <linux-modules@archiver.kernel.org>; Thu, 10 Mar 2022 10:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241269AbiCJKdm (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 10 Mar 2022 05:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241389AbiCJKdR (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 10 Mar 2022 05:33:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FFFC13DE3C
        for <linux-modules@vger.kernel.org>; Thu, 10 Mar 2022 02:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646908336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=StOK/wtVvoGK+JwIiQv3+3Ca437x9eZB8wXtv30yF44=;
        b=Ekan78gi6otwa+eLKF8Opf673l838XHBh9TAjf5ldmMc+Z9m+ZaJCrl1jvEfq4lRP+mSTp
        PYDErFHrst+LI/R1OuJANZm+k4wY6gCkOogisxjRS28BRunISpr7Cvg5eWjH+HVgzYrSqq
        8ten2nnx1rz5MhsTNbqm8zu71cVgIkQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-D4yxJybpOkySvAoE3Lq3VQ-1; Thu, 10 Mar 2022 05:32:15 -0500
X-MC-Unique: D4yxJybpOkySvAoE3Lq3VQ-1
Received: by mail-wr1-f71.google.com with SMTP id e6-20020a5d4e86000000b001f045d4a962so1531040wru.21
        for <linux-modules@vger.kernel.org>; Thu, 10 Mar 2022 02:32:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=StOK/wtVvoGK+JwIiQv3+3Ca437x9eZB8wXtv30yF44=;
        b=YU9R8Kt/hIupBsNpQKZUWApqKXxVVXBDTF5ttNAq/+1/TdTIHNSjpacetkp0j+KaqM
         ZbmsNM6qHElkOcSob9GHFWGULzNSeJfA7A/kPl+a3rw+x9hlIci1Ns4kh2Z/E16nGfQ6
         vfYOndIfIIU/PNF2TtdAhpZbCaNaVHWoeIURCASiYHLsx7RONfvel7Ug1AAeSfDaRNr4
         rCsKbIm9LXJkDQYroANa+LbGR+YfJLI1SSG/nNvcdkYCsHBU8Bop1onlP1cTkfsfe468
         LhWWPP/w2HQ0DnBSHjsqhbnPBxTTHCJK9OFcSkc2W6PjRnM0YFteeI6MTkFBZbr7+X4X
         uT+Q==
X-Gm-Message-State: AOAM532I0QM6sHH2KP6W9U+5Ymls6hxgIYfs+OiK8w+m9Mbnrf6vyYvW
        WAZlvROCy7e3XxtdhuM5aTTwiotFnL3p2JG6o72womRtZrprSj1HMPb/T/BwwUAbx0EMolht3x5
        0WXK4wN3UP++1edr9nv4QJREi
X-Received: by 2002:a05:600c:210e:b0:385:d649:b4ca with SMTP id u14-20020a05600c210e00b00385d649b4camr3025710wml.114.1646908334376;
        Thu, 10 Mar 2022 02:32:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpG91ffPzLVVULM5dWxojTWFzmfWhkR0HTUr1o8UWiOrJ+96oTWGFd/uRnsSWDo5d98ScNLg==
X-Received: by 2002:a05:600c:210e:b0:385:d649:b4ca with SMTP id u14-20020a05600c210e00b00385d649b4camr3025698wml.114.1646908334185;
        Thu, 10 Mar 2022 02:32:14 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id n9-20020a1c7209000000b00389a616615csm7666947wmc.2.2022.03.10.02.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 02:32:13 -0800 (PST)
Date:   Thu, 10 Mar 2022 10:32:12 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org
Subject: Re: [PATCH v11 14/14] module: Move version support into a separate
 file
Message-ID: <20220310103212.lksgok3nsbhkhwbb@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220310102413.3438665-1-atomlin@redhat.com>
 <20220310102625.3441888-1-atomlin@redhat.com>
 <20220310102625.3441888-3-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220310102625.3441888-3-atomlin@redhat.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Thu 2022-03-10 10:26 +0000, Aaron Tomlin wrote:
> No functional change.

Hi Luis,

Sorry about this divergence. This was an error via 'git send-email'.

Kind regards,

-- 
Aaron Tomlin

