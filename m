Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from rhino.giraffe-data.com ([174.143.232.82]:55805 "EHLO
        rhino.giraffe-data.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752966AbcLTBaC (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Mon, 19 Dec 2016 20:30:02 -0500
Received: from localhost ([127.0.0.1] ident=bryanh)
        by rhino.giraffe-data.com with esmtp (Exim 4.72)
        (envelope-from <bryanh@giraffe-data.com>)
        id 1cJ8gb-0000dG-5E
        for linux-modules@vger.kernel.org; Tue, 20 Dec 2016 00:53:45 +0000
Message-ID: <52857.bryanh@giraffe-data.com>
Date: 20 Dec 2016 00:50:41 +0000
From: Bryan Henderson <bryanh@giraffe-data.com>
To: linux-modules@vger.kernel.org
Subject: Build fails when Xsltproc not present
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

I found in building kmod 23 that because my system does not have
Xsltproc installed, the build fails when it tries to use a null string
as the Xsltproc program name to create the man pages.

I believe in that case, it should just skip building the man pages.

Or make 'configure' fail and suggest --disable-manpages.

Or make the make fail gracefully, telling you you don't have the tools
necessary to create man pages and suggesting --disable-manpages.

-- 
Bryan Henderson                                   San Jose, California
