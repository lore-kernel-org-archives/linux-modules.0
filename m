Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF26C433EF
	for <linux-modules@archiver.kernel.org>; Tue, 28 Jun 2022 08:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343959AbiF1IYW (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 28 Jun 2022 04:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343917AbiF1IXw (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 28 Jun 2022 04:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 286FC2CCA1
        for <linux-modules@vger.kernel.org>; Tue, 28 Jun 2022 01:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656404588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qyHqoetnxg5PCrqJPwXKQqt6t1OAl//oQoJPs5YDLec=;
        b=GJI+vadO5wH/VjuzLjcvgXTPN1kZOlvkgSbcCv8XdQzkOTQJmWa6WMhV5wW+w8ahQVL94a
        L3FgN+zBSPBqMOMcb9Z1dxlXyNer+tRamebNPigeHdX6XX356+a2114LJkRn8RJpkh83Qd
        gyZRQ9vgprmDFbfPyQF8Td3S1bvyCVc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-MWfFhehGMb2USDlX-YkAkQ-1; Tue, 28 Jun 2022 04:23:06 -0400
X-MC-Unique: MWfFhehGMb2USDlX-YkAkQ-1
Received: by mail-wr1-f71.google.com with SMTP id q6-20020adfea06000000b0021bad47edaeso1612225wrm.20
        for <linux-modules@vger.kernel.org>; Tue, 28 Jun 2022 01:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qyHqoetnxg5PCrqJPwXKQqt6t1OAl//oQoJPs5YDLec=;
        b=h3ZOCfJNmJckTyiNK9paoIcC7IjxCXFBFBZbmmFDpInjC+OLfJx/V54JMfWz/1mu0F
         NXdJNGAPyvnLwpEpjsMEwGEeKWl1D4dc6b0GMlFN+WAvPPP7WKfqkjIsZvDfethmsZgt
         liIrdStvu8JEPbPS23GlNZselP6y9A8wEdgC9aCKBg3mc3n8pV7lSxIFOr58Ru5tnnac
         VUJyh8PmVKMXRTjleuEZU5IKI0penovsNYDHRffx/NxKl2YFKVTcB6qtIwCOaE2wy0yj
         aWQhgCrvnT0e/RIxm4MFSyf3BP32vlX/x/LH/MXqTrHqb2OcFtyLOIEst/Fut9IsdCgz
         V6aA==
X-Gm-Message-State: AJIora+lEFQsWWJzc+jVOQROUpLz/VID89JKHwBDmkdze5iXjc1gWJbH
        1aIFsjo+nWULK8VjyS3eNt01ynN24gpfZkkbkZv8TP8owbMkOvQdrdI7nw86bSUF8DfTSJWr8sg
        61ws3T/CRQ3VyWQ37ukl2SqUt
X-Received: by 2002:adf:f2cc:0:b0:21b:9efa:611a with SMTP id d12-20020adff2cc000000b0021b9efa611amr16991141wrp.573.1656404584982;
        Tue, 28 Jun 2022 01:23:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u+ynZvW171NUhrXsU4wk5UGlyUXWi+64Z5WVppsnvsN2YX6E0UsI+N4Og47xMumLjtD1Menw==
X-Received: by 2002:adf:f2cc:0:b0:21b:9efa:611a with SMTP id d12-20020adff2cc000000b0021b9efa611amr16991127wrp.573.1656404584830;
        Tue, 28 Jun 2022 01:23:04 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id y21-20020a7bc195000000b0039c362311d2sm24102805wmi.9.2022.06.28.01.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 01:23:04 -0700 (PDT)
Date:   Tue, 28 Jun 2022 09:23:03 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] module: Show the last unloaded module's taint flag(s)
Message-ID: <20220628082303.zelpqlluofwy2hb6@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220627164052.2416485-1-atomlin@redhat.com>
 <20220627164052.2416485-2-atomlin@redhat.com>
 <4ddb64da-58f0-a4af-cf57-a870015a0077@csgroup.eu>
 <20220628074708.fg3ocx3vu7affkxl@ava.usersys.com>
 <b44b2b4a-20e2-2d42-22b1-c1e44c6f999d@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b44b2b4a-20e2-2d42-22b1-c1e44c6f999d@csgroup.eu>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue 2022-06-28 08:16 +0000, Christophe Leroy wrote:
> Are you sure you will never ever end up with a string longer than the 
> length of last_unloaded_module ?

If I am not mistaken, the length of 'last_unloaded_module' has been
increased to accommodate for: the maximum module name, total module flag
count, '(', ')' and '\0'.


Kind regards,

-- 
Aaron Tomlin

