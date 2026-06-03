Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F41390C81
	for <linux-modules@vger.kernel.org>; Wed,  3 Jun 2026 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503856; cv=none; b=mDfikbhAoX9Ckm1p+Qdo5Qq5DZQCULDsOwSj9oMGYUUYyN5aksQ+oFv4px/9kfCNSC7BFGko5m9JGIp4jjTIzTrONDqiRNSjEVmEiEyE2rhhMGcLtCWRFJtmymFI3eTeYPy0SARW1GaYjMlvNxMZ9h4Des+eMUX6XrL5B4t1Hqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503856; c=relaxed/simple;
	bh=yp4ciTApz1ViTYc7BAEO/7pIXSeFt9gT7hQJAu6HPBc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tH4F/noH7UNXYlE8vRMB53b1cHkpdG0GvBqqZY4JGYIyDMB7LfZvPC0zqx5M2GgsCdTJX+PnFgXsrVCvOYoRzBa6gvk6MF4FORH/KuCYGYoF2G96g/aIwOfSZOD32nG6OXlw0GjIVJ5Pe+RUDi4DJ54nqOU1LmDqByJ7bWLaTAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8vqNAE/; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8vqNAE/"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c85a297d2d2so2587440a12.0
        for <linux-modules@vger.kernel.org>; Wed, 03 Jun 2026 09:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780503854; x=1781108654; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pZniL4gn/+6csOa48o24E1Ir6uU5QUrmx49YqPwA5Lc=;
        b=P8vqNAE/vwycy4J7WGzpR9P2N06WoJqX1v4ryvsrWi1DRJLY5PMjw9+qpRwisJ/C0t
         cQ1ejCSTckJLK29s7N+/L8nxObvUWQtp8fItwu2iwGxsvvCtCpQo9ecomWWTSTcJ8MAi
         sl1k1+MbgxMLRNlRVfPzB4UZWbHElytGOIEd9V9XU0NUGsF4JXsGWeMoHnWNgt4StCp7
         R8oZYMTpD17Yai/wl3W9Dq4YxnUJum3SlDR3brvUKcUTkr75uLXFHoY9zkcKZj5jUNp0
         H3ryRIt3PS/unaH6j7CcQ9s0K7PmNl8EhXFzMoq9DClohm3tSDpHnyls/1gxLhRQsA7p
         Rt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780503854; x=1781108654;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZniL4gn/+6csOa48o24E1Ir6uU5QUrmx49YqPwA5Lc=;
        b=btER9C7CWPd85E6r/xKtHUDbwCR5RJVRpRaA/kYLK1Z/42sp5oduM8uxxE8cMg/cfT
         rWrrLf0mI6rVJLBgHAJ/oNMmHA1mn7DFDYu32E0byfBaZuOSN1L6AAtpRmPz241cWovP
         TP78vBWoOSZKIteNFgIVpcOzHWxa2mMivLUSCYrNI6GxMWBuEwiepF4FEwxqt9cQGS2x
         LKAgg+JlG6wFCA3gi3FXGnWAXamidBDAneCyYYz160M+WCD5ZlH86usnw2ZMzNYtpZAj
         19iYz6yPKSoWSiQ/7SiLKzY+qLvCaqjVEbVRt3zWWxIhJpH+hXDo0kvt+3spPEk3EYww
         om1w==
X-Forwarded-Encrypted: i=1; AFNElJ9gGctIGMKWrAlFMUCLyOTdGOhUtGGAnCgHlYfWI5us9rwgxxEG7N997BsQjhFbyn07wsW3OYi3s+7mXuJX@vger.kernel.org
X-Gm-Message-State: AOJu0YzVQYszfUIWmik447/0lvCAE8Mj5Mm4nw2cezG94tRs7trdDtj0
	VqZgIlATgEZvD5UOwC9/lfCpHh793Z34GMszvCZpwKzNwNUDHPYWS9Wri8of5Z14
X-Gm-Gg: Acq92OFqn6NKpzPjdQ8EY4/6Zxt/7VPmR/ht/6Ah8AoHUfFD/ILl50kgpaJHAJMP1nd
	L2vyHfz2GS5EkM23X1jDDp3Sl7uSn4doetH8W9tYBTBcXB+RqQogF6E+6BcrpMMj2cdFSSDlPDa
	LLeSjMgBnoxNqn8sYlgPyuKxpzGdq2+/FmphV1ua/yC6TH9BzxmgYlGr7AiGKkHdyThj6prOdf5
	96wjPnw4GY1ZnFopgtbph8o2K66zu201lyY+ziorag0B7fuenul4zpo+hzCgrSUb9k6sCyTKfmX
	qUCEQoEbvC26quEbb4t7rGXGDjYISzYDHuRWMAUS9bXcfS4igWR9yOoHKQ0MPjc8ecfCmiZopYj
	xfJvr+WYwu+c76Rd3Az/jA5Ok2Z52UyVbBPTzSVbKOjvZDXF96IdUAsOueWE337P9zFEy5w+xpb
	hkrvzM+OQ+xwQmwFkgdYWChizjE2Amxa/nYxg=
X-Received: by 2002:a05:6a00:2d8f:b0:842:3801:47b with SMTP id d2e1a72fcca58-84284e27c0cmr4094954b3a.18.1780503854282;
        Wed, 03 Jun 2026 09:24:14 -0700 (PDT)
Received: from localhost ([2405:201:4027:a919:e2b2:8560:26ea:4d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282372502sm3855246b3a.16.2026.06.03.09.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 09:24:13 -0700 (PDT)
Date: Wed, 3 Jun 2026 21:54:11 +0530
From: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
To: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org, 
	samitolvanen@google.com
Cc: atomlin@atomlin.com, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] module: procfs: fix signed integer overflow in
 module_total_size()
Message-ID: <2k7x7245kygzpa5wzssebsrt5ivpykvvoeiljb5at2yiwgp4fy@fqkcethe4hyx>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

module_total_size() accumulates unsigned section sizes into a signed int
before returning as unsigned int. If the total exceeds INT_MAX, this is
signed integer overflow.

Change the accumulator to unsigned int to match the return type.

Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
---
 kernel/module/procfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/procfs.c b/kernel/module/procfs.c
index 0a4841e88adb..90712aa9dd13 100644
--- a/kernel/module/procfs.c
+++ b/kernel/module/procfs.c
@@ -64,7 +64,7 @@ static void m_stop(struct seq_file *m, void *p)
 
 static unsigned int module_total_size(struct module *mod)
 {
-	int size = 0;
+	unsigned int size = 0;
 
 	for_each_mod_mem_type(type)
 		size += mod->mem[type].size;
-- 
2.43.0

