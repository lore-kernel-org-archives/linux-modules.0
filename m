Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1B2C00140
	for <linux-modules@archiver.kernel.org>; Sun, 21 Aug 2022 18:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiHUSqd (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 21 Aug 2022 14:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiHUSqc (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 21 Aug 2022 14:46:32 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A99D20F58
        for <linux-modules@vger.kernel.org>; Sun, 21 Aug 2022 11:46:31 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id a133so2212378oif.4
        for <linux-modules@vger.kernel.org>; Sun, 21 Aug 2022 11:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=8EoJLa1Ds4DMOa6PyKONK+af45DsIQQA41++HEec4cs=;
        b=OsSnf3s9YW9yL+Bf/0lz8YdYiaAdNN6EwgDLNAFSZo0C4pO22Wc0ZZMHCtmbKUIqDU
         thyU4kNspL9jh9rKuN9cZPwoqqAdTkonIiRWg9agp/AGQKhDiWft52k7lzzY1JspnfJw
         7XdY7XAPIZpjeaDzspL4Bg+vFffuPh1J6c8iIMQqlSPElJ10EOXZjyP1ysubLbuwCOoV
         ZaRgAArMyANCFJoqeYI4J4SpeSMy3MchpSHGOC84kQpT0x+c2tPYmCkymqq9zpk33rvd
         JYaM25i7XaLZYlQMATcc/sLLYXwGV4YhilnwTeB4Sa0J+C9EudY2Tun95ovKfL0ifPXp
         QF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=8EoJLa1Ds4DMOa6PyKONK+af45DsIQQA41++HEec4cs=;
        b=EC79U6XLsaGSyxoekEkWFqFQ+IzjRihfHqiFvFrF2OwldXYD2yrGZubktmNnjex8Lg
         iJQJrfr+NplII4gvimaCwEEHBq/Ip/WeY0HEV86d0eCPIiqTyJG2GZwmVPbXEEzR+HaU
         XzCx7E+FQrnU32wq9KRNzmnoQnJw54/5hKMzoeaFAcau+Vf2PZkuqKmhZlSxZCT9Xf4o
         BQARZbRcQ8NXcXMVOsS/e2TVQdYWT8n+g1iBYmcfORer90Pu8NNaDJaThpaWYU+u0H5g
         j2veGnbYqLIF7N9QqHdWKH+7wT0cDNS92nlQ7PUWkpnV/mVeHlgQTp2eq3q8NWUjT/Ox
         LeMA==
X-Gm-Message-State: ACgBeo311ztkAh4eeg8S1bylZQVC1wmY3rMjBGjV5k2ssoA3PAJ8t1pA
        0Pu2XDshdLt0wLpfCo9JmRe2FrlEjcE=
X-Google-Smtp-Source: AA6agR6u3mCv193elrgPA50nMccWGAO2LVNM/OY7UAXo9OPu3p7Qy2ho0HGDvgnVcy8Cj+GtPw4EmA==
X-Received: by 2002:aca:3882:0:b0:343:57cf:7bba with SMTP id f124-20020aca3882000000b0034357cf7bbamr9315221oia.140.1661107590926;
        Sun, 21 Aug 2022 11:46:30 -0700 (PDT)
Received: from [172.31.250.1] ([47.184.51.90])
        by smtp.gmail.com with ESMTPSA id p39-20020a05687056a700b0010d5d5c3fc3sm2641933oao.8.2022.08.21.11.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Aug 2022 11:46:30 -0700 (PDT)
Message-ID: <148c7e0e-3de9-e3ad-81a3-5444864e9bfe@gmail.com>
Date:   Sun, 21 Aug 2022 13:46:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     kernelnewbies@kernelnewbies.org, linux-modules@vger.kernel.org
From:   Ian Pilcher <arequipeno@gmail.com>
Subject: Faster, incremental depmod when adding modules?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

When installing 1 or more out-of-tree modules within
/lib/modules/$UNAME, is it possible to run depmod in an incremental
fashion - adding symbols from the new modules to modules.dep[.bin]
without re-scanning all of the other modules from that kernel version?

I've tried specifying the new module files, but that seems to create a
completely new modules.dep containing *only* the symbols from the new
modules (which obviously isn't very useful).

-- 
========================================================================
Google                                      Where SkyNet meets Idiocracy
========================================================================
