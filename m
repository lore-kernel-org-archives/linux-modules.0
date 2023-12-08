Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZhcxv5D"
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2C610E6
	for <linux-modules@vger.kernel.org>; Fri,  8 Dec 2023 00:29:50 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4257988fd5dso11549981cf.3
        for <linux-modules@vger.kernel.org>; Fri, 08 Dec 2023 00:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702024190; x=1702628990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iGl6ZzHg1OBYEiK2GB9JZoVjq8WgRuHbCmeVKei0R+M=;
        b=eZhcxv5Dz2/Fov8K99ZN8jryUHy28Yk43dGPSh0Y9hx5bWlEsNBQYWw5ghMMT92mzb
         VJiRZGKk2cSk+GwpngMrMRXih8JwbX2BA3u487AsfTYeyUxqB8fjKYB2Y/UYswPIl6XF
         q7cmQKYysMKFsIIWMmAAhesWkVI2SGh2L2esPiA+/DhibfvRcAKsQjZgs+7YB5HMGPG0
         wBqG4ilSoT/T+R9A2WrpOuQtt3E/RrQ6+LpGl1TAL4tTxccW5qM7HT8Br1yfqb/eavOl
         zUXFX33jFQoNlF2aF00gJGIzySg+hRuRGSuXOzDs9jwsEKPUNI9u5c3ABJLhe4RYY0+A
         43Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702024190; x=1702628990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iGl6ZzHg1OBYEiK2GB9JZoVjq8WgRuHbCmeVKei0R+M=;
        b=Ua3w5oeeTpt6WHNXCVL3zDgyZXsEblYn5eCe0E+LodzJIf2DDTQyNwhYbUgZmpzWbZ
         Xoj5xuT+WXsbutJoeSJn8VeRtvCHU2jmdCTwt4H+Ko/Kzs78S62K4o3lv4IB7Bw+nHN+
         FvLarnSrYkJSSeL1lX8u86QqiMNLf3v29Hj7sgmbnCjptC3imH0GENHieii90KA0Krzt
         GW+bnUCTaaKxqkqjsDHoO+3xt/hj3PalAN49O/T4R+fR3ItljhrdCKt6Lj1gGaB9ZYH8
         Y6wmVBKPc7mtsdlqjhRmgU1Xnyq5Yb2xSD4apdRzdC6xj6DuaEKxQC5e3lIT0gDNoVSW
         5klA==
X-Gm-Message-State: AOJu0YztW3QAEPZ7EMK6uJmI7daXdQP16/g6MYuspu3b9aKiGeJGH1BU
	FHTBIsoTlTF40S+pd4RKwt8=
X-Google-Smtp-Source: AGHT+IF5e1Yymkyk6jMM4yDYgCdmtrEEG9JqQrc+dwUpHgEOJOs732DihdqFnFvwEA9sc+8Q+P680A==
X-Received: by 2002:a05:6214:5592:b0:67a:a721:cb1a with SMTP id mi18-20020a056214559200b0067aa721cb1amr3759857qvb.123.1702024189955;
        Fri, 08 Dec 2023 00:29:49 -0800 (PST)
Received: from pek-lpggp6.wrs.com (unknown-105-121.windriver.com. [147.11.105.121])
        by smtp.gmail.com with ESMTPSA id ez9-20020ad45909000000b0067a89dc28ecsm619155qvb.95.2023.12.08.00.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 00:29:49 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Subject: [PATCH] module: Remove redundant TASK_UNINTERRUPTIBLE
Date: Fri,  8 Dec 2023 16:29:34 +0800
Message-Id: <20231208082934.1969383-1-haokexin@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TASK_KILLABLE already includes TASK_UNINTERRUPTIBLE, so there is no
need to add a separate TASK_UNINTERRUPTIBLE.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 kernel/module/dups.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index f3d7ea1e96d8..9a92f2f8c9d3 100644
--- a/kernel/module/dups.c
+++ b/kernel/module/dups.c
@@ -207,7 +207,7 @@ bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
 	 * optimization enabled ...
 	 */
 	ret = wait_for_completion_state(&kmod_req->first_req_done,
-					TASK_UNINTERRUPTIBLE | TASK_KILLABLE);
+					TASK_KILLABLE);
 	if (ret) {
 		*dup_ret = ret;
 		return true;
-- 
2.39.2

