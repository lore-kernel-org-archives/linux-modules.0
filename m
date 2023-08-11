Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964C3EB64DD
	for <linux-modules@archiver.kernel.org>; Fri, 11 Aug 2023 03:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjHKDtq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Thu, 10 Aug 2023 23:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjHKDtq (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Thu, 10 Aug 2023 23:49:46 -0400
X-Greylist: delayed 625 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Aug 2023 20:49:45 PDT
Received: from smtp-gw.pt.net (smtp-gw.pt.net [206.210.192.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C470A2710
        for <linux-modules@vger.kernel.org>; Thu, 10 Aug 2023 20:49:45 -0700 (PDT)
X-ASG-Debug-ID: 1691725159-09411a10a558ef10001-vc2Alt
Received: from mail.pt.net (mail.pt.net [206.210.194.11]) by smtp-gw.pt.net with ESMTP id B7UHtnhbE0HQRmWo (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO) for <linux-modules@vger.kernel.org>; Thu, 10 Aug 2023 22:39:19 -0500 (CDT)
X-Barracuda-Envelope-From: lesrhorer@siliconventures.net
X-Barracuda-Effective-Source-IP: mail.pt.net[206.210.194.11]
X-Barracuda-Apparent-Source-IP: 206.210.194.11
Received: from localhost (localhost [IPv6:::1])
        by mail.pt.net (Postfix) with ESMTP id EEF1C17F22AA
        for <linux-modules@vger.kernel.org>; Thu, 10 Aug 2023 22:39:18 -0500 (CDT)
Received: from mail.pt.net ([IPv6:::1])
        by localhost (mail.pt.net [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id uznONP5mQGpV for <linux-modules@vger.kernel.org>;
        Thu, 10 Aug 2023 22:39:18 -0500 (CDT)
Received: from localhost (localhost [IPv6:::1])
        by mail.pt.net (Postfix) with ESMTP id A90E717F2401
        for <linux-modules@vger.kernel.org>; Thu, 10 Aug 2023 22:39:18 -0500 (CDT)
X-Virus-Scanned: amavisd-new at pt.net
Received: from mail.pt.net ([IPv6:::1])
        by localhost (mail.pt.net [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id bLJogyefCtku for <linux-modules@vger.kernel.org>;
        Thu, 10 Aug 2023 22:39:18 -0500 (CDT)
Received: from [192.168.1.121] (75-15-243-201.lightspeed.snantx.sbcglobal.net [75.15.243.201])
        (Authenticated sender: lesrhorer@siliconventures.net)
        by mail.pt.net (Postfix) with ESMTPSA id 937DF17F21FE
        for <linux-modules@vger.kernel.org>; Thu, 10 Aug 2023 22:39:18 -0500 (CDT)
Message-ID: <c6d34094-7363-a462-5043-768f688aef66@siliconventures.net>
Date:   Thu, 10 Aug 2023 22:39:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Content-Language: en-US
From:   Leslie Rhorer <lesrhorer@siliconventures.net>
Subject: module issues
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ASG-Orig-Subj: module issues
Content-Transfer-Encoding: 8BIT
X-Barracuda-Connect: mail.pt.net[206.210.194.11]
X-Barracuda-Start-Time: 1691725159
X-Barracuda-Encrypted: TLS_AES_256_GCM_SHA384
X-Barracuda-URL: https://smtp-gw.pt.net:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at pt.net
X-Barracuda-Scan-Msg-Size: 1353
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.112581
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

Hello all,

     About a yer or so ago, I upgraded one of my Debian servers to 
Bullseye, and it killed the 10G NIC on the server due to issues with the 
device driver in the Debian repository.  I jumped through all sorts of 
loops and hoops to try to get it working, but I finally had to give up 
and resort to using the 1G interface. Recently, I tried upgrading 
another server to the new Debian Bookworm, and it worked for that 
server, so apparently the issue has been fixed in Bookworm.

     With that in mind, I went ahead and upgraded the original server to 
Bookworm, but the NIC remains dead.  Unfortunately, I cannot find ny 
notes on what I did originally to try to get the 10G interface working 
and to shut it down in favor of a built-in port.  I do recall I tried 
compiling what was supposed to be the correct firmware driver and also 
changing the udev rules, but I do not recall the exact details.  I have 
tried several things, including re-installing the firmware, but nothing 
seems to work. The Ethernet interface does not appear on the system in 
order to be able to specify it in /etc/network/interfaces.  What can I 
do in order to try to get the 10G card working?

     The card is an Asus MCB-10G_PEB-10G NIC and uses the bnx2x.ko 
driver. The system uses an Asus AMD-64 motherboard.

