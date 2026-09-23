Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782ED58F088
	for <linux-modules@vger.kernel.org>; Wed, 23 Sep 2026 22:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202941; cv=none; b=RkhFUVhVg5hc5dap/k3BGEu28WwHlZYxxa0hEpl0WezzCgPcU+JFZHhMy35lo+VMlA3j1O8AqrmxhUFqZkfHWGIkBUE7NaUIw3M2M8U0wt0dM+Jn5uggH+wjT5Xme5pCLeZOWvdPzL4LE+HR3aQWssAQNeWz3WY102MPem/5jyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202941; c=relaxed/simple;
	bh=7+HPraKPOEEC0zH9j6rk9hElqURen8UcjSYaIkCewNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iKAL/xDWF2R+vt3XxV0cuHgAWcrGmUhejWyyszfNyFmboymcDI+cfZNyckLZDpP6+KHRhJ4N+8U9GNJQ20g7cUJJjvOwZkSB8u0DFR7NgWbfOujaE2F5RjxRzNcQFjfikC283qaC7GYZB5Mnped4v63otNsLXh1f2JVBbN8I6Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZHbs6rZ; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZHbs6rZ"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466cc88a0d7so1039886fac.2
        for <linux-modules@vger.kernel.org>; Wed, 23 Sep 2026 15:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202934; x=1790807734; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TpRbRk/7nf10Za9Cg3XtZGbhDhlA5QBMQA01q9nUzRU=;
        b=dZHbs6rZpuB7z/DUI6ILyFchMegR9p8yq3sbjLWRmTXz58Jq8E6A+DERsHOrlyDWN2
         XsG0ybOCewYJ1Vh9yZc8VTqJfZx4u9ncMr9sFXdrviAdj2d+T+/uFVE/SqdeBSAw8uA2
         /Yjc4bEvNlGdME5zsZz7fBu/9xGYPM8gVAItIpC2HTd1CmcWWh0KqiVRgo6LvsZK6O7F
         WWWac8p0OxpWErwgM0rI9Qn2pVZc3itbh5iOuOvTCF1bj+zGqjyR3EZvA9aeBLu3vRUD
         fa80WKsqb4cw2rYFpehhzQu7fMtxhzmgYQQPLcV1n/r9H2nUICQZxIBiODe3dqyrhYtc
         azSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202934; x=1790807734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TpRbRk/7nf10Za9Cg3XtZGbhDhlA5QBMQA01q9nUzRU=;
        b=Yy+VNsM/SuuJOAWufUdDyt93YT5qqdI7rOM1Lt/pNf4LWFJCdZaSZKwIMe9UgjKrz5
         wxtQU78w4OaaCVI9nMo4oNAxPm3V3Vebh1mTqeYRJxukbe1Ur5x7omY/+9HrdwKuw8pL
         1a8FeOYbXjHEKEPCqwxgN1nF/sSKswH7Uhdub8eGOq0n5N6s52FlsTgN5de3DRprOa0L
         Z1q4+PuFAaaeApnJQG+2D715K//2r9pkpSH9Eb8t/frcAwOUuZc6khbB4GAQvC6n9LCw
         Xpz7x3iENoNCDUyB9Mg96vfz83uahkmXjV0HYMupcQ/4P8Tyc90GRny/AR2MnqrlF9dU
         +k0w==
X-Forwarded-Encrypted: i=1; AKwUvBwf2cTP5Jt6qex34dl6iv/O+ZfSPzG8DCdjnaNf888oW8ye+CC1gTRsmE4VOoEtnyVKdAsSsPuuJdwHiS9m@vger.kernel.org
X-Gm-Message-State: AFuF++kutiopxx3H+UVaLdLKHzbfelUePvDtyz3IULAYleqBlMNGdUzB
	rIfHit9n1VqWabpJmPFRHY/cqlqfrO6OSRb4zPkkCg4nrOxhLtjm0WD2
X-Gm-Gg: AYBFou3HbzgQhUYP5MpKZ3fqkkqwjwyQr6H6lnxtthAJcXCDkDpsJK4OKu0E/0cH/Bh
	3xkL63CGg6zR4S6dR8gQN69Ss+wJIFNLEiAg7hT7t9KRkJsHfxdT2BCXK7jYmVp63KypYWEKPGw
	4qlU1BB0dxFcI3qFDqpa6K1gGhy2OIu1zZbhGh62wJZF016Uy2k4gdjSgnvLHuz1TaKypnwb6yt
	0nJNNesT4lynG3B9rM/S9LgwrdzTn+ZclUKqpeDPZ8uCkFcsfd9HSpgwbT4vihvZaN54eddli8S
	RNrBdWP6ewbQNYdjJ+WUE+ZlDaGgM1xmCvalXvhPQjf/kkfXlC9ZXrhXWe8plQgGImYqwtRjd1b
	V6gyCrqJqtA9kIFVpNIh1aYmQP7kjkfDXPsP/eWDi9/ttdiPJPcGsXD6ktE+s0DXxBZ4ewEhWRg
	kOsI3T8GA/GIIZgHv5Ma7sUD6yla50J6t0NPhcBLjRZVNm8i5C5iCaRlIuH9OuTXhVkRN/sD1kg
	nXH0l/QtN5Wlg2X0HEHKpkTWrKao3GUHWJIegXwqLBGp1uI8lA5FkDSpcxrLUsUEbUQ5NAiIBV6
	+Tr7sLKPucxQSpfDpFw=
X-Received: by 2002:a05:6870:3263:b0:48f:e107:317b with SMTP id 586e51a60fabf-491e6efd09bmr708378fac.46.1790202934055;
        Wed, 23 Sep 2026 15:35:34 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:35:33 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:48 -0600
Subject: [PATCH v11 24/38] selftests/dyndbg: Enable FT_classmap_inheritance
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-24-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=5931;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=7+HPraKPOEEC0zH9j6rk9hElqURen8UcjSYaIkCewNg=;
 b=SGPNFN3H4AgPho7JeKIVU6CQQlOkXMvxRExTka1tTKCiqj64NTSSY/gE+VsIBZZRvvKXGPxpQ
 OiyXbaR6zX4Cufn+4KSI9YPtkxD016TGQ5HHiKv1oyG0JOGH91UHKqS
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Exercise classmap state inheritance between supermod and submod,
verifying that class settings and controlling parameter states propagate
from parent classmap definitions to dependent class users upon module
load and during runtime reconfiguration.

Add FT_classmap_inheritance to exercise classmap parameter propagation
across test_dynamic_debug and test_dynamic_debug_submod. Enable it under
modular_tests and register its 8 golden record checksums.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 84 +++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index c279c795867b..5a805cb30e6c 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -64,6 +64,7 @@ function ifrmmod {
 }
 
 # Clean up any leftover loaded test modules at initialization
+ifrmmod test_dynamic_debug_submod
 ifrmmod test_dynamic_debug
 
 # ===========================================================================
@@ -189,7 +190,7 @@ function FT_grammar_ok {
 
     # use 4 keywords (max 9 words inc flags)
     ddcmd "module foo file bar.c func buz class D2_CORE +_"	# 4 keywords
-    #ddcmd "module foo file bar.c func buz class D2 line 100 +_" # 5 keywords
+    ddcmd "module foo file bar.c func buz class D2 line 100 +_" # 5 keywords
 
     # 3. Dedicated lineno range grammar assertions (side-effect-free proofs)
     ddcmd "line 42 +_"		# test exact line syntax
@@ -291,6 +292,78 @@ function FT_basic_queries {
     ddcmd "file $f =_" "$f"
 }
 
+function FT_classmap_inheritance {
+    v_echo "${GREEN}# TEST_MOD_SUBMOD ${NC}"
+
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+
+    # modprobe with plain-old +p & 3 class enablements
+    my_modprobe test_dynamic_debug \
+	"dyndbg=+p;class D2_CORE +pf;class D2_KMS +pt;class D2_ATOMIC +pm"
+    verify_control_slice '\[test_dynamic_debug\]'
+
+    set_param 5 /sys/module/test_dynamic_debug/parameters/p_level_num
+    verify_control_slice '\[test_dynamic_debug\]'
+
+    my_modprobe test_dynamic_debug_submod
+    verify_control_slice 'test_dynamic_debug_submod'
+
+    # fresh start, to clear all above flags (test-fn limits)
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+
+    # load submod, which loads supermod
+    my_modprobe test_dynamic_debug_submod \
+	"dyndbg=+p;class D2_CORE +pfs;class D2_KMS +pts;class D2_ATOMIC +pmf"
+    verify_control_slice 'test_dynamic_debug'
+
+    # runtime changes to both
+    set_param 0x57 /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    set_param 4 /sys/module/test_dynamic_debug/parameters/p_level_num
+    verify_control_slice 'test_dynamic_debug'
+
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+
+    # set super-mod params at load-time
+    my_modprobe test_dynamic_debug p_disjoint_bits=0x16 p_level_num=5
+    verify_control_slice '\[test_dynamic_debug\]'
+
+    # see them picked up by submod
+    my_modprobe test_dynamic_debug_submod
+    verify_control_slice 'test_dynamic_debug'
+
+    # Real-time mathematical proof that load-time (modprobe) parameter parsing
+    # and runtime (sysfs write) parameter configurations are perfectly equivalent!
+    local hash_modprobe=$(slice_and_hash_ddctrl '\[test_dynamic_debug\]')
+
+    # Fresh load with default parameters, then configure them dynamically at runtime
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    my_modprobe test_dynamic_debug
+    my_modprobe test_dynamic_debug_submod
+    echo 0x16 > /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
+    echo 5 > /sys/module/test_dynamic_debug/parameters/p_level_num
+
+    local hash_sysfs=$(slice_and_hash_ddctrl '\[test_dynamic_debug\]')
+    if [ "$hash_modprobe" != "$hash_sysfs" ]; then
+        echo -e "${RED}: Load-time vs runtime parameter equivalence check failed!${NC}"
+        exit $ksft_fail
+    else
+        v_echo "${GREEN}: Proven: parameter load-time (modprobe) " \
+            "and runtime (sysfs write) are equivalent!${NC}"
+    fi
+    # --- Live Content Fingerprinting Phase ---
+    log_start
+    echo 1 > /sys/module/test_dynamic_debug/parameters/do_prints
+    echo 1 > /sys/module/test_dynamic_debug_submod/parameters/do_prints
+    log_stop
+
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+}
+
 # Built-in Feature Tests (Can run on any CONFIG_DYNAMIC_DEBUG kernel, modular or monolithic)
 builtin_tests=(
     FT_grammar_ok
@@ -300,6 +373,7 @@ builtin_tests=(
 
 # Modular Feature Tests (Require CONFIG_MODULES=y and test_dynamic_debug*.ko available)
 modular_tests=(
+    FT_classmap_inheritance
 )
 
 # ==============================================================================
@@ -383,6 +457,14 @@ function GOLDEN_RECORDS {
 #K= 02e4fd94602e108cb89bfc70d47a5dad FT_basic_queries.5
 #K= f03a7ca7316e8db4c0e16523dc41e75d FT_basic_queries.6
 #K= c518a50ba30ba8099d0dc874a27ecf16 FT_basic_queries.7
+#K= fb294f02a4207b28b2a874524ef07afd FT_classmap_inheritance.1
+#K= 7a0b87016fdc237077dfe96bbbb3661b FT_classmap_inheritance.2
+#K= 2784d60f5056fc5cc03b3ceb854293f5 FT_classmap_inheritance.3
+#K= bf66aaf8ff612272c0cda29778ed2131 FT_classmap_inheritance.4
+#K= 49fdd29d91a4c1d16f8b59bb431e741b FT_classmap_inheritance.5
+#K= a8aa244285d048b5ebe33061fa99c424 FT_classmap_inheritance.6
+#K= 3060b86a0f553dd5a826bb7023284925 FT_classmap_inheritance.7
+#K= f43e0aff8a4b38435b73d90ed8100d1b FT_classmap_inheritance.8
 EOF
         # Read the K-recs and skip those for tests that can't run
         while read -r line; do

-- 
2.55.0

