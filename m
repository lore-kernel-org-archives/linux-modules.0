Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F8F317161
	for <linux-modules@vger.kernel.org>; Thu,  2 Apr 2026 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139597; cv=none; b=GvrzRzAhg7tsToOFfscI+U38jHG7VhhW6ImU9XcISl4fmssXu3sW+JvSgJs7yz6u5l8vS1HG4hN/ZBZJuW9ZASv9aMVU0M36w1NhRbaOiGi7vXQ7zLSyE6iKQ1AMS3Qnn2AC8+VqjbKoqGe2gw7+e827aVgGsQTsb7RSgwasQkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139597; c=relaxed/simple;
	bh=cyVMP9Kyo1scTrFB2LAaQ/90OVciv1KyB7OE0taNBB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sea8IvcNYc3eWA8fbY3oQ4gS61kJTH/NNT9sH1zm9tgsuTg1t2rwhCxVjDy9EhHmiaNDAQqN4H0s0RaCr3e/JeMSJBpBUCs1asHSvJ5nusItGJwMRya6UexHb15icUMEVMpR3aTzHcOam58nXD4MVSXH8X/vp0tSYmZWCIzKBgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SdjdwZH7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SdjdwZH7"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cfb723698so848034f8f.3
        for <linux-modules@vger.kernel.org>; Thu, 02 Apr 2026 07:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775139592; x=1775744392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bkH+lobUTgIXjLrXq0Aorb2k1wsHUrp5cbKHFvjFzNY=;
        b=SdjdwZH7ORwF0PTFgr47fahmbNTCkh8sH2yGbNg+Px3nxe6LufZXy4A1ljskE43AWZ
         EeNOEV39EtEos49BEaOvJ+XtX5i+lryx9zHD+P22it0wBq54BbZqO7ax95SgtlvgYIEI
         x0fXKDLmTuCXt0gGCgDcRQJJsl8jk7cXj1LMwYEzr1Roqo4ARb3AWSfVSTQ8sXDiG7fT
         XF9iW2YiZ3pTDKdwmvGZhoZeEP9PaNc3k5QHvnE74HQptla3pQ3OuVnT3m91autnLkMP
         n+DEKDLLoAZRvHDn+rOALzqXa91YJiB+tmXuYX94xBwklZsl2qI1UjTmWkxkwcGLPaQx
         ehsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775139592; x=1775744392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkH+lobUTgIXjLrXq0Aorb2k1wsHUrp5cbKHFvjFzNY=;
        b=DOZiquhFvQbzgPTiLdDW2jHqxt7m9IwsaK/B1KXgGtTea+X2WmUsnIiqFziAmXywyE
         uaUfYl/wQgGJDxqVVKl4rkjhw79cF11gEkWF5W2q7/xUsr6yT0jnsp15Lcx72UY44IuR
         JGrsGwmq9EwH8yAEQfQ1tAbf3fzyCFgCCO0zWhTz4XcMXSHLujjx0Xedm02XoPMeYi7q
         6fpmqZ47lgtH6A+79xN3/fx3nDGhwahJ6cuK6RAh3/HoxJWpaEWNvB/ds1DAxTtUmHys
         qv9KuWtw3ga9ckdM+FTtkTRoQcUMNz71TCwRSj0sqO3vl4gDvBrrs4OiNJyVE1/gq1HZ
         QpSg==
X-Forwarded-Encrypted: i=1; AJvYcCUoLl1vjJreKEu5sfR0bhvcbAlwJDRgko8wQZKto6nlIZn5hcUEJLf8sIfjdkyTgYQP0xJbHNzNicDHdfn8@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz/jOYUGRMQYHVDozTWh9yfOUoFoRZ/H0ppueOFn9fzOyFubi3
	uP2qRPh9jzihO+Qs4dnsRIRNhnKR2CbDik227xlaq8cfBNRoveVpfXOh7ZTLbkisS6g=
X-Gm-Gg: AeBDietatM1P/eIWsu0xEGBKWYvdtGLnaceh39g17DiaVrG0PIcxb0xa1aVYideF/ww
	CFuqahvVxe14e5X/yDGA6ij5/pg9w7WDs6EitoSgzF1v2mgf3v1NwI82WTzstKET89uzXHkwKl7
	jqnXjWI9w4vf6N5g32SIFrkRzk+r7EvyyNeKr4LRJRyGdP1jjx+iJ69MEza/WvnQDqVc/lXXhp/
	fjBtjRzclP+Y1dx9dY8fR5TJGXCRDw/TdubwfT/XCXcUbra7Binw4Ga/qzbIP5rbOOZd5KBmlwh
	ERKhcwqwahFKxl5vRjaznx212pmD6J/B22jUq1+txSF+HYVL149kKt4bCa/t7W+wvPjNlYffbsD
	s9hKRPwBVs+30Adfhzb1n2yF+kS4LwB9OU39zFwsMtBwYFxuU0nLqI2OMuEwYzQYNE3SXORswHJ
	wVLswDmV+GI5Hd/gN2EtLEp9iYSWwlMKoTVixX9S6K
X-Received: by 2002:a05:6000:250a:b0:43d:4c:229f with SMTP id ffacd0b85a97d-43d150e161amr13806399f8f.44.1775139592291;
        Thu, 02 Apr 2026 07:19:52 -0700 (PDT)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e56fesm8459818f8f.27.2026.04.02.07.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:19:51 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH] kbuild/btf: Avoid relinking modules when only vmlinux changes
Date: Thu,  2 Apr 2026 16:17:16 +0200
Message-ID: <20260402141911.1577711-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5f9ae91f7c0d ("kbuild: Build kernel module BTFs if BTF is enabled
and pahole supports it") in 2020 introduced CONFIG_DEBUG_INFO_BTF_MODULES
to enable generation of split BTF for kernel modules. This change required
the %.ko Makefile rule to additionally depend on vmlinux, which is used as
a base for deduplication. The regular ld_ko_o command executed by the rule
was then modified to be skipped if only vmlinux changes. This was done by
introducing a new if_changed_except command and updating the original call
to '+$(call if_changed_except,ld_ko_o,vmlinux)'.

Later, commit 214c0eea43b2 ("kbuild: add $(objtree)/ prefix to some
in-kernel build artifacts") in 2024 updated the rule's reference to vmlinux
from 'vmlinux' to '$(objtree)/vmlinux'. This accidentally broke the
previous logic to skip relinking modules if only vmlinux changes. The issue
is that '$(objtree)' is typically '.' and GNU Make normalizes the resulting
prerequisite './vmlinux' to just 'vmlinux', while the exclusion logic
retains the raw './vmlinux'. As a result, if_changed_except doesn't
correctly filter out vmlinux. Consequently, with
CONFIG_DEBUG_INFO_BTF_MODULES=y, modules are relinked even if only vmlinux
changes.

Additionally, commit 522397d05e7d ("resolve_btfids: Change in-place update
with raw binary output") in 2025 reworked the method for patching BTF data
into the resulting modules by using 'objcopy --add-section'. This command
fails if a section already exists.

Fix the unnecessary relinking issue by also excluding the normalized form
'vmlinux' when invoking ld_ko_o. Adjust embed_btf_data() to first use the
--remove-section option to remove the patched BTF section if it is already
present.

Fixes: 214c0eea43b2 ("kbuild: add $(objtree)/ prefix to some in-kernel build artifacts")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 scripts/Makefile.modfinal | 14 ++++++++++++--
 scripts/gen-btf.sh        |  6 ++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index adcbcde16a07..2981745a172f 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -54,9 +54,19 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
 	$(cmd);                                                              \
 	printf '%s\n' 'savedcmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
 
-# Re-generate module BTFs if either module's .ko or vmlinux changed
+# Build final module objects.
+#
+# The *.ko files are usually independent of vmlinux. However, special handling
+# is required for module BTFs, which need to be regenerated if either the
+# module's .ko file or vmlinux has changed, as vmlinux is used as a base for
+# deduplication. Consequently, vmlinux is included in the rule prerequisites.
+#
+# The regular ld_ko_o call is conditional and is skipped if only vmlinux has
+# changed. The exclusion pattern used in the if_changed_except call contains
+# '$(objtree)/vmlinux' to match the exact prerequisite and plain 'vmlinux' to
+# cover the case when make normalizes './vmlinux' to 'vmlinux'.
 %.ko: %.o %.mod.o .module-common.o $(objtree)/scripts/module.lds $(and $(CONFIG_DEBUG_INFO_BTF_MODULES),$(KBUILD_BUILTIN),$(objtree)/vmlinux) FORCE
-	+$(call if_changed_except,ld_ko_o,$(objtree)/vmlinux)
+	+$(call if_changed_except,ld_ko_o,$(objtree)/vmlinux vmlinux)
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	+$(if $(newer-prereqs),$(call cmd,btf_ko))
 endif
diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
index 8ca96eb10a69..6d4e629c79ca 100755
--- a/scripts/gen-btf.sh
+++ b/scripts/gen-btf.sh
@@ -104,12 +104,14 @@ gen_btf_o()
 
 embed_btf_data()
 {
-	${OBJCOPY} --add-section .BTF=${ELF_FILE}.BTF ${ELF_FILE}
+	${OBJCOPY} --remove-section .BTF \
+		--add-section .BTF=${ELF_FILE}.BTF ${ELF_FILE}
 
 	# a module might not have a .BTF_ids or .BTF.base section
 	btf_base="${ELF_FILE}.BTF.base"
 	if [ -f "${btf_base}" ]; then
-		${OBJCOPY} --add-section .BTF.base=${btf_base} ${ELF_FILE}
+		${OBJCOPY} --remove-section .BTF.base \
+			--add-section .BTF.base=${btf_base} ${ELF_FILE}
 	fi
 	btf_ids="${ELF_FILE}.BTF_ids"
 	if [ -f "${btf_ids}" ]; then

base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
-- 
2.53.0

