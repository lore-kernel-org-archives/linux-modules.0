Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DAAC433EF
	for <linux-modules@archiver.kernel.org>; Mon,  4 Jul 2022 15:02:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiGDPC4 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 4 Jul 2022 11:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiGDPCz (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 4 Jul 2022 11:02:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1509B6395
        for <linux-modules@vger.kernel.org>; Mon,  4 Jul 2022 08:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656946973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cbPVFg5HfSLExs8n8PnCNX+mcFJDkOgFSN/8HExwOpA=;
        b=fGKwC9sD834OKPdgPbmNQG60hMcTPrZmypmXCSNyVSiy/3Qcnda8v1VyyuLv+37omUjOd+
        HVjq8e1bcfh9gCdlFgnVF4aZN8cpZuHy0iS1cqz3YorM5bJZmKOhvidHzrUUCwhKFBxgbs
        YvE/Tu3jotq5apfWinVJmWZ6x+YLrJE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-QYEw-9DVOnmn_IK7dTvXXg-1; Mon, 04 Jul 2022 11:02:52 -0400
X-MC-Unique: QYEw-9DVOnmn_IK7dTvXXg-1
Received: by mail-wr1-f72.google.com with SMTP id u9-20020adfa189000000b0021b8b3c8f74so1465359wru.12
        for <linux-modules@vger.kernel.org>; Mon, 04 Jul 2022 08:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cbPVFg5HfSLExs8n8PnCNX+mcFJDkOgFSN/8HExwOpA=;
        b=OtvkNXLnfQcZ9/E3O+Hy6USnbGewoBYs9zbGAax0YCSvTp2WjVmiR6ajBGzbfV/4P4
         z3OyVTCSB0bFIy6Xb/fOwwjlFscABpSmZXLBNaV+SFbdKkYF657oSikn2kYeLNye7kV7
         5qKSkbcQ6U6jQDbMElAkdOlCrZnNXm0X8LHy8A/0yfMSdBvucwLyjrK4ImNQ5rHWLt29
         NiObo20NSxoIPurpe8MtjYGHGpB7uxkvf0h1Sq+D4d/8yg7Ky/84ABC5tzwSWCV43c4f
         O1QdHOYDxmdB0k4M0Eq22pLvfIBdkwNPoa0MiUE7BxKnPMmPN7fpz+wszGNCmAePpGkn
         cNag==
X-Gm-Message-State: AJIora+HYLPZKxyzFv1/tHQyeqTEKnG50WQPJ85BPrNjyQ9uaICRZ7it
        RgYsBtxvA/QgN6xaPUHT48ZXO5hYnA5jXgSZzTm2Ifi3iXnsh7pFzY7fGSIExKYbwuIKjfSABd+
        8yGFCHOn06V2LsSoQgsTenTnR
X-Received: by 2002:adf:e702:0:b0:21d:6900:ea1c with SMTP id c2-20020adfe702000000b0021d6900ea1cmr6477189wrm.620.1656946971545;
        Mon, 04 Jul 2022 08:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sPzYr8Iuz4JWFuy/bxMQLAhayVyp/s0V3e6xRbpAesBg1i9PcXXW7Pw7n7srJq66M4b08TZw==
X-Received: by 2002:adf:e702:0:b0:21d:6900:ea1c with SMTP id c2-20020adfe702000000b0021d6900ea1cmr6477151wrm.620.1656946971326;
        Mon, 04 Jul 2022 08:02:51 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b003a04b0bcb43sm19451631wmi.40.2022.07.04.08.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 08:02:50 -0700 (PDT)
Date:   Mon, 4 Jul 2022 16:02:49 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Christopher Lamenter <cl@linux.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-modules@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, oleksandr@natalenko.name, neelx@redhat.com,
        daniel.thompson@linaro.org, Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] module: kallsyms: Ensure preemption in add_kallsyms()
 with PREEMPT_RT
Message-ID: <20220704150249.rwxekvj7nlarja6b@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220703123109.3770204-1-atomlin@redhat.com>
 <CAB=NE6VYhoXbS2TYN_+TP1P+C5kbnNBNr2vr8V9Fs2dvm6NL5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB=NE6VYhoXbS2TYN_+TP1P+C5kbnNBNr2vr8V9Fs2dvm6NL5g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Mon 2022-07-04 07:55 -0700, Luis Chamberlain wrote:
> Aaron, thanks for the patch! Your commit log however reads like an
> optimization but it's a fix that needs to go to Linus, as such, can you
> update it to explain clearly *why* it's a fix.

Hi Luis,

Sure - will do.


Kind regards,

-- 
Aaron Tomlin

