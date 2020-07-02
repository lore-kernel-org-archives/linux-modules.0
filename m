Return-Path: <SRS0=4tua=AN=vger.kernel.org=linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2DDC433E0
	for <linux-modules@archiver.kernel.org>; Thu,  2 Jul 2020 01:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 742E42082F
	for <linux-modules@archiver.kernel.org>; Thu,  2 Jul 2020 01:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKY0gKFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgGBBUv (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgGBBUu (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Wed, 1 Jul 2020 21:20:50 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC88C08C5C1
        for <linux-modules@vger.kernel.org>; Wed,  1 Jul 2020 18:20:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id w16so27108105ejj.5
        for <linux-modules@vger.kernel.org>; Wed, 01 Jul 2020 18:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=tIoV/Sa2c2cUu6rxcYNBZFs2BFRuXiGF1apxmof91xA=;
        b=mKY0gKFKXnWxYDITC23gkYOtpI0eDvLn2rLaX97ZCKlQdpKyDDpnfjIvNAVKYj/soo
         q/4JZvao0SvcXw1AMARt8EH0AjgiYavEbokGn5NMnV1Z6E8MVrhivnra/rD29IDI4V6P
         kpS+wkgi4i7UrQIJb/rAHP0t+psc3I6QkpDmZ84l6mvE/2cDg0fF8vCoFlNIQRgfRZVo
         RxsfNTl1CHZ3Ih5h0cx7pwe1k4aVw0rlwVKiZqeJeitHP0tB6wr6gXecn3wGHTPIw0f5
         04GI7C8h2+33uRj7nOLKAH+CzcQ4c/r5LBRI76No2tjcJaFUZZjZJwuYFeIcV68wt+Pn
         LA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=tIoV/Sa2c2cUu6rxcYNBZFs2BFRuXiGF1apxmof91xA=;
        b=K6BaCsQVb+0CeMHaLuyI7M9hwb33KdE3DHu9IrOogmxnrv2CfagVaKzgYBOq+6psxz
         o+hm2NH95eYqa3NeyXV067Dy1IHrkBKUa7yoZ410bpM34BoJJRo2JoSvO3DaDhyqqtdX
         EI5kcTwouYACl91dx8etFuvW4cqPCmCuv6SdUkSrWTCw6SVKMTkBKQQX63AEB0C6wjmn
         YyhTc+E3wlJUVs4vcgPXq8uiRv2hOBRDJZ5MYW40tB+MFxXR3eitgZhdBQm2NnQRz2JE
         co4NwCmWtnm23byMkxHMFs1JKHC8wR817ww/8dn0jqIZBWK1nW27dGbRRc6ki5W33P/P
         +bkA==
X-Gm-Message-State: AOAM530426KPtIdv/k+Lk4eGPtC8UsYBNaOVAeet5xz/1VncffJjZZSo
        8nhrOphtUimadzhSzlD3Ave5PMM6H8k=
X-Google-Smtp-Source: ABdhPJzMAyyQ5wioe7VR4F/elgMLlodJ3ljvn37xS0wqJD5KUkKgk2aJq8EIGdl+90H2XscJqUmDjA==
X-Received: by 2002:a17:906:abca:: with SMTP id kq10mr10215058ejb.515.1593652848838;
        Wed, 01 Jul 2020 18:20:48 -0700 (PDT)
Received: from [192.168.1.197] (ip-89-177-205-133.net.upcbroadband.cz. [89.177.205.133])
        by smtp.gmail.com with ESMTPSA id n5sm5689412eja.70.2020.07.01.18.20.47
        for <linux-modules@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 18:20:48 -0700 (PDT)
Message-ID: <b0894a8dd06ccee4326bcd7ff14e1f871bd45080.camel@gmail.com>
Subject: Support for /usr/local/lib/modprobe.d
From:   Jan Tojnar <jtojnar@gmail.com>
To:     linux-modules@vger.kernel.org
Date:   Thu, 02 Jul 2020 03:20:46 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: owner-linux-modules@vger.kernel.org
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hello.

We are working with a project that ships a blacklist file [1] that is
supposed to be installed to modprobe.d directory but it is not clear
what the default installation path should be.

Distros will typically install modprobe config files to
/lib/modprobe.d but it is common to use /usr/local as the default
prefix [2] for manual `make` invocations. The manual page [3] does not
list /usr/local/lib/modprobe.d as a supported location though.

In the past module-init-tools added [4] support for that path but that
repo appears to be abandoned and it does not look like kmod supports
it [5].

1. Am I missing something, or was this an omission when porting
modprobe to kmod?
2. Could the support be added?
3. Should we default to /lib or /etc for manual `make` invocations for
now?

[1]: 
https://github.com/medusalix/xow/blob/4aa49f27cb6fcb3da995da9e8d51167bed40f520/Makefile#L22
[2]: 
https://www.gnu.org/prep/standards/html_node/Directory-Variables.html#index-prefix
[3]: https://man7.org/linux/man-pages/man5/modprobe.d.5.html
[4]: 
https://git.kernel.org/pub/scm/utils/kernel/module-init-tools/module-init-tools.git/commit/?id=9454d710137be3799f343cc9d0f833f0802e2111
[5]: 
https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/tree/libkmod/libkmod.c?id=f5434cf5fc5b567359e1b9207bbab24c6782cfbd#n65

Cheers,

Jan

