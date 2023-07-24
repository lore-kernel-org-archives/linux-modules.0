Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16289C001B0
	for <linux-modules@archiver.kernel.org>; Mon, 24 Jul 2023 19:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGXT4g (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Mon, 24 Jul 2023 15:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjGXT4f (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 24 Jul 2023 15:56:35 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F88170E
        for <linux-modules@vger.kernel.org>; Mon, 24 Jul 2023 12:56:34 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b9efedaeebso9259905a34.2
        for <linux-modules@vger.kernel.org>; Mon, 24 Jul 2023 12:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690228593; x=1690833393;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0HbIfON9h7OtlOqGplVgAJ/Ron1dfOFrue7VmqDYzg=;
        b=crPFvQtdjlfsZH7MpiPK1Kxk3y2lF9ttEZpjmspmH6ykaMgRNmx8vVhNu8tDsoZnh1
         9HsbwZl0ntezYfUYK2teM2WqTSpPihU6jtJjfATnkfCt/+jyWHva3/oD27iFsidkPSoD
         8Wb8FsdM12BiAOyAou7oYEnsXo7fI5AknoIR4mmxRak4DjeiAeRy7znsj0TPSVSlzmG/
         k5+avxyuwn+/HhIeKoBGZm9xlmNmIGNwLzRDfx/BNKa94e2PkQ+F/AUL03Jbg8QUzrIF
         rH4Nsh7QlWSLzbc6RY5LD9YuKbXcSCx1Je5roCO22R7UeyRCcM4PdNhUteGuF1dYT4F2
         UnpA==
X-Gm-Message-State: ABy/qLYjcbymO0te/1eQRw7aIIfUn1ITlkheaoZ80iCPm+HnUznyBxKS
        oo+dwJTlhQtoEzNcLGsriOuBJq6q8AYvMRigVSDWdTkSyGyE
X-Google-Smtp-Source: APBJJlGy8FHZDVrssAfEDgGHScfjKPZjYZWznrOxt65Wocsqqyr5rTphmuoPNIEOMBE7bKR1W0V4AWAMQMX5N468FTXqgMvgSHHN
MIME-Version: 1.0
X-Received: by 2002:a05:6870:955e:b0:1bb:51ab:a7bc with SMTP id
 v30-20020a056870955e00b001bb51aba7bcmr7056676oal.1.1690228593534; Mon, 24 Jul
 2023 12:56:33 -0700 (PDT)
Date:   Mon, 24 Jul 2023 12:56:33 -0700
In-Reply-To: <ZL7Una9vhJpX+dkb@bombadil.infradead.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e82d5806014102a7@google.com>
Subject: Re: [syzbot] [modules?] KASAN: invalid-access Read in init_module_from_file
From:   syzbot <syzbot+e3705186451a87fd93b8@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev, mcgrof@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git on commit 910e230d5f1bb72c54532e94fbb1705095c7bab6: failed to run ["git" "checkout" "910e230d5f1bb72c54532e94fbb1705095c7bab6"]: exit status 128
fatal: reference is not a tree: 910e230d5f1bb72c54532e94fbb1705095c7bab6



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 910e230d5f1bb72c54532e94fbb1705095c7bab6
dashboard link: https://syzkaller.appspot.com/bug?extid=e3705186451a87fd93b8
compiler:       

Note: no patches were applied.
