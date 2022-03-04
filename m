Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E04CC433EF
	for <linux-modules@archiver.kernel.org>; Fri,  4 Mar 2022 11:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbiCDMAY (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 4 Mar 2022 07:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiCDMAX (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 4 Mar 2022 07:00:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E01F01AAA54
        for <linux-modules@vger.kernel.org>; Fri,  4 Mar 2022 03:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646395174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0hZpcrT4T8XD6Mp3T/V7L8uTti8hHiq/LHVjIVxUD8k=;
        b=XKTNQoqP4S8W21SqxSEL6Fsq/GvQfGDLbI+/t3ryFIUPDObWAFuaa+4JjZ+OyEeROY7fev
        vam3D1atuP7+FXMowZKi4EoqR0BxQy7Uao5IrqoOWculF7U/u/9A4r4HkOswYeS8BsRUb0
        98UPq7sTutjQDWIoedqjVPjQwJOe3is=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-d6iExmqtPiiRzaNkT-RWSA-1; Fri, 04 Mar 2022 06:59:33 -0500
X-MC-Unique: d6iExmqtPiiRzaNkT-RWSA-1
Received: by mail-wr1-f72.google.com with SMTP id z16-20020adff1d0000000b001ef7dc78b23so3272775wro.12
        for <linux-modules@vger.kernel.org>; Fri, 04 Mar 2022 03:59:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0hZpcrT4T8XD6Mp3T/V7L8uTti8hHiq/LHVjIVxUD8k=;
        b=MJ2NH7s2UnPlxSDtOi5iuewkqXZCor8XJEvtKPiXAn3GnF4SpWxIxJLC6ZOiWRk7vL
         dPztDD2s9pr/RITBTbGvLpmXH5HGLxI33kJ4/6Kh/QhWGLXSuNJJxQveLoFmB5rovhYc
         rrczH14iz5MJmOpbFTMZt7rUM9pCwEFNuKT3Eh0Seux5e5uM1YMs31I1AtLWwFn8XR44
         fQCuiHTTOmK234oz7XCcL8776IiFVLPgaxCrtRhXb+Zwi2kE2H+vZTGKcHS1dbemTFws
         0ogg28Wmh0mGqmr6EkcS83DR2xQCQTZHu5oFKBLUK+83NqQMtDn/wgOut0pHjDT14O+m
         RlaQ==
X-Gm-Message-State: AOAM5320IQbud9bJcf/7Q7Uw8P1jJ/QkgRbdDGF3gJ74UPeRlxWwRiqt
        3KK3jaFV+Jr/P8HzLRPGLlt2fBzbTdGy0fjhd51zbHL0ZlSjY8fjd+A4QfsncMhmAMlDSMe1xLm
        fhGihSYtjYPFpOxncWb6/NTqU
X-Received: by 2002:adf:ea01:0:b0:1ea:8200:8ae5 with SMTP id q1-20020adfea01000000b001ea82008ae5mr30067511wrm.607.1646395172699;
        Fri, 04 Mar 2022 03:59:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfCYRYmPjKjzMoD8NXHJIbCgcjtQs9sSa52UxrnMZHRl2r2JzrHrLHUBPM8THYFCs9P4DdYw==
X-Received: by 2002:adf:ea01:0:b0:1ea:8200:8ae5 with SMTP id q1-20020adfea01000000b001ea82008ae5mr30067499wrm.607.1646395172480;
        Fri, 04 Mar 2022 03:59:32 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5006000000b001e75916a7c2sm4412880wrt.84.2022.03.04.03.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 03:59:31 -0800 (PST)
Date:   Fri, 4 Mar 2022 11:59:30 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
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
Message-ID: <20220304115930.vn7l3np465d6bbfc@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-14-atomlin@redhat.com>
 <20220302161917.gx5icfszakoye4uh@maple.lan>
 <20220302203153.3kcmwu662szf3drt@ava.usersys.com>
 <a87aac32-52b1-3d56-6331-1c241fea032f@csgroup.eu>
 <YiDEmRf3X0fxSayK@infradead.org>
 <20220304111207.pmopl7vgxrniwava@ava.usersys.com>
 <20220304115444.jlfv6abblqgyzscj@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220304115444.jlfv6abblqgyzscj@maple.lan>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Fri 2022-03-04 11:54 +0000, Daniel Thompson wrote:
> Aaron: Are you OK to add the new kdb file to the "KGDB / KDB
> /debug_core" file list in MAINTAINERS? Mostly I'd expect to just
> Ack changes and move on... but I'd like to be in the loop.

Hi Daniel,

Sure - no problem.


Kind regards,

-- 
Aaron Tomlin

