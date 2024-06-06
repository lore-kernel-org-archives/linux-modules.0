Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA86194A7B;
	Thu,  6 Jun 2024 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680713; cv=none; b=JJnQfQ9eZ1oJkmhJJs8hHf59ElTDFwE8q/zldDM8fNOJmd7bntSyNsXMUaZMsgWQQxYk5DVvHVfNSrDMbgWx/EhvsH+fRfVCh9Ed3LLQWW11167KeTppbsgTuyuS7xPAWdWPaxV/uWhzv01p2U9XgH0LmLFaCyuSEwKDmpbHwvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680713; c=relaxed/simple;
	bh=ODGzjweFeoree6nHb5uFzGqYtS4ZQpIt+5T64RUbNC8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ZA7yU5v0p3rlxMnVo3kKNWntJ0RwI+Q9RikDv//5VvE0djjP3ANLPs9gqaOZk/JYUdCkGAECUe0QAWeM4F/JVb9lBmAHgdbhP5cLnP9hqRETqbs/jmBH/DtWAkHv1Tau8Y3+7D+XlHc0c201MIO1dIw94+L+YRGesrl3Z3uvzQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8aErASN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8aErASN"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42115de211aso1125645e9.2;
        Thu, 06 Jun 2024 06:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717680710; x=1718285510; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pc46OCfAOPOc0DXVm3ED9dwoGHWTkw+46Tb7BWlK+IM=;
        b=K8aErASNIl/e9Y6TH/A97MT+p/Gzd0b7HbLq6F/i0ug8xm4s7vOIEQ6gVWkoOrMoDQ
         OC55pTehW7kELUnFjZzR0bqXb0LO8iGbXPudiPA9wzcuSef8/yOVFoZQ1ikM3N06bM23
         QyqrD3R6zBVGYyA2g6IH9Lq1Mi7rS3kpVrjWr5wgRX4YuHcjhixSyhqA//Z7Tcp5riK0
         jTwhHF8Z00LP23svsfjYxO/Jq0Ilnlnem63LNlEoop7Ar6kGCYZ8YpkHM1jsnFZOTj4P
         elEXPxvECZ95UL6fsT6+5ykniZoLXsGycn/u+2fwZH1MouHPQjhKWICQdTPPdJADQx1l
         4MsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717680710; x=1718285510;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pc46OCfAOPOc0DXVm3ED9dwoGHWTkw+46Tb7BWlK+IM=;
        b=MgtLjmZNU5GN3Ct4PczGQjL/NiqsCH5zogm3FR2UITa2ZhHWOiq/ndbgtjKvA/UfJG
         C3iz7ym5JV5AnunMjylfLY04UYbl5tvWNpmissOWADOF4Nh78euXrICyKla4uNDVTSpO
         71H0lWS+O2x6NDOnnBQyraNTH7YW23C0ayTCBjCEwXg017IsUixWKKSAMicUTGvOGMeP
         nfmsUlDuHDAilLDuHLz1uOjMcX9q1g9Q4LxZNYo38BQZin0NQZ8DpFrOvNPlAsrPFHDe
         8mS2SRSafE6ZY9wCXaDc/t8M6w+TucZDPvU4laeeZtriyoPKc4ha5nhBDJkbuPsL6g/i
         D5rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmNwzCrq1qFLIfurAb1K/FqzmHQiWvuQFeK2SVhaFn6MOMHSncKFc9/BBj+H1PJYKV2IGNtyevJkTkWetfhCm/4ebtJX9L/OXbWwIhliy5+G5FjxhVCwUctGOLW95TWSfuoAwvYFrB8YEa1g==
X-Gm-Message-State: AOJu0YwWMPjua7dQLnr72GgOs9gK6C6g/5/gPogJNrML63H3qsAHUs7h
	icv5yUhn8CELAZ0HL6WRyxj2tK8g+pgzrpWxwnXDQFKFPDwXd3EC
X-Google-Smtp-Source: AGHT+IE6clwhdGuRe16gAPufWBAAtBn/8lZZ26ukPH+iTwvczvZblV6M1+0fbDYfj14OBhEGkOMgOA==
X-Received: by 2002:a05:600c:1c97:b0:421:5237:7843 with SMTP id 5b1f17b1804b1-42156261703mr43568125e9.0.1717680710214;
        Thu, 06 Jun 2024 06:31:50 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:dd1d:7683:25a1:47a7? ([2a09:80c0:192:0:dd1d:7683:25a1:47a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42158110dfesm57679255e9.19.2024.06.06.06.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 06:31:49 -0700 (PDT)
Message-ID: <230772fc-1076-4afb-8f7a-e7c402548c3b@gmail.com>
Date: Thu, 6 Jun 2024 15:31:49 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: mcgrof@kernel.org, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: "Daniel v. Kirschten" <danielkirschten@gmail.com>
Subject: [PATCH 6.10.0-rc2] kernel/module: avoid panic on loading broken
 module
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

If a module is being loaded, and the .gnu.linkonce.this_module section
in the module's ELF file does not have the WRITE flag, the kernel will
map the finished module struct of that module as read-only.
This causes a kernel panic when the struct is written to the first time
after it has been marked read-only. Currently this happens in
complete_formation in kernel/module/main.c:2765 when the module's state is
set to MODULE_STATE_COMING, just after setting up the memory protections.

Down the line, this seems to lead to unpredictable freezes when trying to
load other modules - I guess this is due to some structures not being
cleaned up properly, but I didn't investigate this further.

A check already exists which verifies that .gnu.linkonce.this_module
is ALLOC. This patch simply adds an analogous check for WRITE.

Signed-off-by: Daniel Kirschten <danielkirschten@gmail.com>
---
  kernel/module/main.c | 6 ++++++
  1 file changed, 6 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index d18a94b973e1..abba097551a2 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1886,6 +1886,12 @@ static int elf_validity_cache_copy(struct load_info *info, int flags)
                 goto no_exec;
         }
  
+       if (!(shdr->sh_flags & SHF_WRITE)) {
+               pr_err("module %s: .gnu.linkonce.this_module must be writable\n",
+                      info->name ?: "(missing .modinfo section or name field)");
+               goto no_exec;
+       }
+
         if (shdr->sh_size != sizeof(struct module)) {
                 pr_err("module %s: .gnu.linkonce.this_module section size must match the kernel's built struct module size at run time\n",
                        info->name ?: "(missing .modinfo section or name field)");
-- 
2.34.1
