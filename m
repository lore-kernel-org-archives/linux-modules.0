Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2CD28C5C1
	for <linux-modules@vger.kernel.org>; Mon, 30 Jun 2025 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751294176; cv=none; b=IaiPd3FjjmeMceWXvTH6fxW35h2NBcstWBID1ts7s9ab02qQkUMBAqdGeOivR9+RAwtEJ54MuTAAif/a+e6VIPRUzFYGOfoTl6o8gAVtoeiJLQpMy2N+bzsuSDunm/IVHBpT636cO8HLnA9KDL7txs4xoGi6+YtFihcInYh60/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751294176; c=relaxed/simple;
	bh=WGV704Eo/1OZH4+nrAQdrHsDuKUNEEzinf+2Kc0d6hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxXjxBfJjScYfgxzO7UqSIxaqDkBnIr6Y3OQnKXEVLGRoIoU8XmREHp93ZATkhMfsxXiEMLYRt3P8A72sOZPqOVGGmVqWf370SPM4Us1zBD/Wacd6Gjf2dnqTfE8JsTZ51qG1dw/2+IdP0ZV9l6nC2ltn8Na+C65eypS5vMLzfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UEf1HAsj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UEf1HAsj"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-453398e90e9so17295615e9.1
        for <linux-modules@vger.kernel.org>; Mon, 30 Jun 2025 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751294173; x=1751898973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYGr+w4GfcUkgYiVXycPX4UxZzSKxs2cIGs5isKRNhY=;
        b=UEf1HAsjZsitoMXcpw7QOe+2Fw5eHKJeBoA2QBD5Euxn9+YmBOeRDhzmOHJhl/ide5
         qWiXiB/eOJFXDCJWwxL/+GjmVqvL/RNQoF+PQTdwmnbwkC+MFWp/fzAHid+WIwVCRH7R
         1/2h+BZ2NbCtsL8yrGNWbpn8kUlaA9roZ4z9PWwL3tgnWZM7nopXwh2twC4B+yT/idgP
         ntP6zKwp9wV5D+mFFS3lcmfuiFvNFsNAwafC6hQjSpQDu4xri4jRT6cJrT2Rtr0y9ZWb
         Vvg0Kc/iM/EduRv5UvAC/OLdM2rlNEKzZMUgUHRHB/Sc0F0GELoIv/S2bcWGODPrSMTx
         8AZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751294173; x=1751898973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYGr+w4GfcUkgYiVXycPX4UxZzSKxs2cIGs5isKRNhY=;
        b=NlR3uugGt55XZmbA88ogsywJq7lAy9n9XMVBJSMJ8Iq05pECMt9snmdvH+WPvWGqsx
         av6e7KuYZLShEFb/HCwJ0QqdH7OVpVsMzWGl+Q4Ounjfa5YSfIC58GoyCu7VoxvMXWIG
         Vt/ebEF7X76R11jQFajhcr7J7vcsYK21mwZwqeItBYb6wCwq9xeU/BjyV+iMqCi9RDgs
         RMWXmRRUCk6bfxt/NfOuQm0x6NZY5m94wKkFXdQMZF0Xys7s59/Z71GiRAsu5f5O76rw
         J8EpyuvhVAiptnGkMzSLr3yXIEdRu3XNBFPe0bHcS5O+At8nqxfX4iUgiiawI7N471bb
         4LPw==
X-Gm-Message-State: AOJu0YyzAmOgWDg+6FUs2sinYHVm48YSpYfIr+e+IaaSVTDwHBSkJdZo
	A7JC3MaComp0OEKGhVav2rc63nKLNmt+UOk8CooQKK4+fAMReqOUISV1s47snHU4lF0=
X-Gm-Gg: ASbGnctsg7XQHHVBkjSDEEr/kjmv69Z7Y9GKc3JimSQGb5hvHWyZb5RqZ6/bw2VwIDo
	MqiVlmoYC/vkkg84e0cGIESSoDewJDLqk7cXLulBcDn6n4B15A0xViQnNj3o2HSBwDE9r9bIclh
	lmjnfRLllzIZx7qsCTZzwaEzfi8Kc8CWESLBJDhT9BrjpO3Lj8w83VtoVjxT4/rxIhvlBh9SdJD
	2DoriwWEIRSSMGxQJmPTDMZT37B8ui1HJpTP4PBr/BPXuCK0x/SLOoWJW1h8UnsFsInotyozkB+
	pK++T+jJtqyjxTWDssNFqpAcgySKh50AZVTE7EDgW2hXgBjG+fRp3aaeyc3lxA==
X-Google-Smtp-Source: AGHT+IFKdSX/7On1Q0wj0XjtBIz1cLSj6YHaIR75PLNUipp/xh/X/AUZR64SxbA4mNUTIjWDWDxDXg==
X-Received: by 2002:a05:600c:3112:b0:43d:26e3:f2f6 with SMTP id 5b1f17b1804b1-4539ebf5521mr48135765e9.5.1751294172898;
        Mon, 30 Jun 2025 07:36:12 -0700 (PDT)
Received: from zovi.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a4064b1sm139691695e9.29.2025.06.30.07.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:36:12 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] module: Restore the moduleparam prefix length check
Date: Mon, 30 Jun 2025 16:32:34 +0200
Message-ID: <20250630143535.267745-4-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630143535.267745-1-petr.pavlu@suse.com>
References: <20250630143535.267745-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The moduleparam code allows modules to provide their own definition of
MODULE_PARAM_PREFIX, instead of using the default KBUILD_MODNAME ".".

Commit 730b69d22525 ("module: check kernel param length at compile time,
not runtime") added a check to ensure the prefix doesn't exceed
MODULE_NAME_LEN, as this is what param_sysfs_builtin() expects.

Later, commit 58f86cc89c33 ("VERIFY_OCTAL_PERMISSIONS: stricter checking
for sysfs perms.") removed this check, but there is no indication this was
intentional.

Since the check is still useful for param_sysfs_builtin() to function
properly, reintroduce it in __module_param_call(), but in a modernized form
using static_assert().

While here, clean up the __module_param_call() comments. In particular,
remove the comment "Default value instead of permissions?", which comes
from commit 9774a1f54f17 ("[PATCH] Compile-time check re world-writeable
module params"). This comment was related to the test variable
__param_perm_check_##name, which was removed in the previously mentioned
commit 58f86cc89c33.

Fixes: 58f86cc89c33 ("VERIFY_OCTAL_PERMISSIONS: stricter checking for sysfs perms.")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 include/linux/moduleparam.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index bfb85fd13e1f..110e9d09de24 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -282,10 +282,9 @@ struct kparam_array
 #define __moduleparam_const const
 #endif
 
-/* This is the fundamental function for registering boot/module
-   parameters. */
+/* This is the fundamental function for registering boot/module parameters. */
 #define __module_param_call(prefix, name, ops, arg, perm, level, flags)	\
-	/* Default value instead of permissions? */			\
+	static_assert(sizeof(""prefix) - 1 <= MAX_PARAM_PREFIX_LEN);	\
 	static const char __param_str_##name[] = prefix #name;		\
 	static struct kernel_param __moduleparam_const __param_##name	\
 	__used __section("__param")					\
-- 
2.49.0

