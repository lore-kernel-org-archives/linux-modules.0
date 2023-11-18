Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F3jRmmh2"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60E910D5
	for <linux-modules@vger.kernel.org>; Fri, 17 Nov 2023 18:58:08 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5bc3be6a91bso29617207b3.1
        for <linux-modules@vger.kernel.org>; Fri, 17 Nov 2023 18:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700276288; x=1700881088; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua0IE78OI3V4iuwp2QSoKWUWADgF+ZXc9DJoA62znV8=;
        b=F3jRmmh2EUK+OfbPUNe20oapoSvEhNicFeHmxJ/ixVlLf1ZBkP22OAHd1hmZUCvZsu
         1VaOG1HutflZuwff1N+aB+ElGpfYHHU4huPgCGLS5IZyL4BRRPQ8VynifDc2AdQB3/AZ
         LQr8z+SzK+8PjJn21ItvbT/PJLJ3KSP9engLbXThkfCdz9Z12vPovpZ/s8mLqf9A+mXq
         wEG/0DJy8KVjt0wODrqkkmyxJO2w+loCUzYFLF6rD6dw6h9bxF5mjwovRIMujp1TbwC4
         WYN/glhBqY5rX8A4edfLXeIaR7hNqbYMSTGlnh669YFyHe0NwOxbEmVhM3L7YXwH/IKe
         ou1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700276288; x=1700881088;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ua0IE78OI3V4iuwp2QSoKWUWADgF+ZXc9DJoA62znV8=;
        b=W8CkHMJdoBJhIzU/DaLejLswXmE4kkmErPU6gRILWziRWtBlyEmo0Ow2mItPzthyHh
         9uDywoAdcec+HY/qpNjFdkruQn1IbflOufmVYbwHVzHW0LTMAjHFVuZqFuzH7UwzwKn1
         /02wBCDS0IwEek41IFp29+Ii3s11LC5V6+Eemsk3r+CWRleHo1n6egWmWsvUgRnsaZuk
         FB3j+GukpWkSmMTUpUEZuNhZEvJS3oRhkCZIrDlw3ak9PZ9xE+wMSQErfZdQoajoe9lv
         mBNzsw+qGJTjPwU0YpElex8LyVMJRLU55jyPHs8Mof3Iicn6J7taRC+qVuUmJ9lqnq/Y
         8okg==
X-Gm-Message-State: AOJu0YwLpMNqNmpouVD8VuYm33iauNwqxxzEkGzvPJ/AJBM4gGwhGlZE
	2QQ7+K5rBCjdCju3cl+htB2AhvNe12cT
X-Google-Smtp-Source: AGHT+IERm4l8aRNMXSza7sGbPFbUkdTe33rpYyqpHWn57Z3BfKIw6SvQM+EZkHQPY3+Yu4peV7KukI7LkV3P
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a25:e6c1:0:b0:daf:3e84:d016 with SMTP id
 d184-20020a25e6c1000000b00daf3e84d016mr29963ybh.2.1700276288083; Fri, 17 Nov
 2023 18:58:08 -0800 (PST)
Date: Sat, 18 Nov 2023 02:54:42 +0000
In-Reply-To: <20231118025748.2778044-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231118025748.2778044-1-mmaurer@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231118025748.2778044-2-mmaurer@google.com>
Subject: [PATCH v2 1/5] export_report: Rehabilitate script
From: Matthew Maurer <mmaurer@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Luis Chamberlain <mcgrof@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Laura Abbott <laura@labbott.name>, Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="UTF-8"

* modules.order has .o files when in a build dir, support this
* .mod.c source layout has changed, update regexes to match
* Add a stage 3, to be more robust against additional .mod.c content

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 scripts/export_report.pl | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/export_report.pl b/scripts/export_report.pl
index feb3d5542a62..dcef915405f3 100755
--- a/scripts/export_report.pl
+++ b/scripts/export_report.pl
@@ -55,6 +55,7 @@ sub collectcfiles {
     open my $fh, '< modules.order' or die "cannot open modules.order: $!\n";
     while (<$fh>) {
 	s/\.ko$/.mod.c/;
+	s/\.o$/.mod.c/;
 	push (@file, $_)
     }
     close($fh);
@@ -120,10 +121,14 @@ foreach my $thismod (@allcfiles) {
 			next;
 		}
 		if ($state == 1) {
-			$state = 2 if ($_ =~ /__attribute__\(\(section\("__versions"\)\)\)/);
+			$state = 2 if ($_ =~ /__used __section\("__versions"\)/);
 			next;
 		}
 		if ($state == 2) {
+			if ( $_ =~ /};/ ) {
+				$state = 3;
+				next;
+			}
 			if ( $_ !~ /0x[0-9a-f]+,/ ) {
 				next;
 			}
@@ -133,7 +138,7 @@ foreach my $thismod (@allcfiles) {
 			push(@{$MODULE{$thismod}} , $sym);
 		}
 	}
-	if ($state != 2) {
+	if ($state != 3) {
 		warn "WARNING:$thismod is not built with CONFIG_MODVERSIONS enabled\n";
 		$modversion_warnings++;
 	}
-- 
2.43.0.rc0.421.g78406f8d94-goog

