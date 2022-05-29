Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF05C433F5
	for <linux-modules@archiver.kernel.org>; Sun, 29 May 2022 15:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiE2Pl0 (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Sun, 29 May 2022 11:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiE2PlZ (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Sun, 29 May 2022 11:41:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197DC62CF6;
        Sun, 29 May 2022 08:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=jDtBiS1mUBWcsUw4mBXSfXdXjtkxN1+yZg+fwvDQjzs=; b=YkURvs1rP1D86BOSH1hRLVg7YJ
        aJaXeqxhYD8mumjuYYJN2jHXqsUd3eI+1Hsy6VEdlOhpQ5L6hxKaSm6z3HBMT7L4HZluVzOIUXby0
        bRWn+S/+Jm/EAGa8ne1GqRW3MJHlMhRFomX0R1RktS+/mgKmqCbSFbxT/mB8WfINoKRF+QPE7+BDv
        7Cy9B7SXTr0CibMwehXu9/ysJwnUh4CL+vdilflEuJjXjNNskujBWgq7CXvc41gx/N9UW0HL6/5lg
        eN080TFKEvg0CWDxEckbn+YoDDEXqRd9otjiw2iEaAi5/yYtvudUOC8FBVKHg7H/H3IyC8TopKsVv
        JnIrzw0g==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvL2a-002mdq-Vm; Sun, 29 May 2022 15:41:18 +0000
Message-ID: <ba2fb3ff-22dd-d68e-fa99-02de39240f20@infradead.org>
Date:   Sun, 29 May 2022 08:41:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Modules list
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Leslie Rhorer <lesrhorer@att.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
References: <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0.ref@att.net>
 <dd7e69ce-41a4-cc5e-5a15-0ae9fc52aad0@att.net>
 <7999b7b4-3b58-a9c4-4756-445e54404f0f@csgroup.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <7999b7b4-3b58-a9c4-4756-445e54404f0f@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>



On 5/29/22 08:21, Christophe Leroy wrote:
> Hi,
> 
> Le 29/05/2022 à 13:35, Leslie Rhorer a écrit :
>>         I sent a subscription to the linux-modules list which seemed to be
>> successful, but when I sent a message, it bounced.  I sent the message
>> to linux-modules@vger.kernel.org.  Did I do something wrong?
> 
> Obviously you did it right as I got your message through the modules 
> list (I'm not subscribed to linux-kernel list).
> 
> Christophe

and you can see it in the lore archives:

https://lore.kernel.org/linux-modules/7999b7b4-3b58-a9c4-4756-445e54404f0f@csgroup.eu/T/#t

-- 
~Randy
