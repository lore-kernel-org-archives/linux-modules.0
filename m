Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752334AbdI2UIN (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Fri, 29 Sep 2017 16:08:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D3F7981E05
        for <linux-modules@vger.kernel.org>; Fri, 29 Sep 2017 20:08:12 +0000 (UTC)
Received: from [10.3.116.249] (ovpn-116-249.phx2.redhat.com [10.3.116.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACFEC17C48
        for <linux-modules@vger.kernel.org>; Fri, 29 Sep 2017 20:08:12 +0000 (UTC)
To: linux-modules <linux-modules@vger.kernel.org>
From: Andy Grover <agrover@redhat.com>
Subject: python3 version of python-kmod
Message-ID: <9f813b6b-7e14-99c9-778a-3214308f5db5@redhat.com>
Date: Fri, 29 Sep 2017 13:08:12 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Heyo,

libkmod supports Python 2 bindings. It would also be great to build 
python 3 bindings -- I think this is just a matter of building against 
python3 headers, and using cython3 instead of cython.

I tried copying the python section in configure.ac and replacing all 
instances of "python" with "python3" but no luck -- I don't grok 
autotools :(.

Can anybody help?

Thanks -- Regards -- Andy
