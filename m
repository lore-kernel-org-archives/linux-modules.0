Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B0B1A4B88
	for <linux-modules@vger.kernel.org>; Wed, 25 Sep 2024 23:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727307598; cv=none; b=HsVq/NYpWd79C7fMOgcPBBdL4n5LZZjsYU0YHN+gXCi0GiCkSE1idQtgq8gd1OlRX0Rx3kBHuGAvYk6twZlZVeBe5JT2+Q8rt1RvKbBhTQFhIJPGe8Iqe4gsyfvlX8iYYk5c9DNAaJW4pvcQXdnsbu7N7FFPhswHFFtCk6QOGzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727307598; c=relaxed/simple;
	bh=KqzbIRZaiTcASB5/z7j1pBJp9u/nLEzrmBQfqdwdS+0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r3xqYZwoacdnKcw/C8OiBD7TQRo63XKSDwvTE3ZhAGhmblIj8XLZQNX5Zk6kZFvWkA5SRFqoGG3geU+d6v9QwxFY2EYn0LNMMEytp6KxgfpXxHuzYO/C7i+KdY+veBQMh5vCVxwJGowu40GDk6uMiQZS8Dav8qtw4t4tniRHp6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oKP1Z8NY; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oKP1Z8NY"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02b5792baaso693976276.2
        for <linux-modules@vger.kernel.org>; Wed, 25 Sep 2024 16:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727307596; x=1727912396; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9tQH+085gbT8g6utnUHSGPzzhaq/BvRPx+qqG98o3U=;
        b=oKP1Z8NYzCW3wdrGLbSd0+z4YaAtfoT+55NhpDw9t6rLvl0jWbL70Dl2B/Kh5tmKYJ
         G2GupxkGy83tyRGyRSwtyT2FpBXLIt2wWabdNX8ecp8Q2pvr7ur+V5PCfEkE/+QQAfmD
         doEyyE0OPuqskrD0GERU3wJK2bYsEcRh+wphK+xOCG4PE7A5T8fic6AcJjgLfY1bIffK
         /CbN1lGPMw30iGanZXxYrQ0ALBD+BIzgPamajUHMsFR/lRfTlwLxJXbYLLPl0Dr0HhEc
         SppOLafq9h5SiDULiY5MytW1aEBXpqMqaP3MuoJrIfc3QQdNjcXXYfo484YrusBlvFOK
         t6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727307596; x=1727912396;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9tQH+085gbT8g6utnUHSGPzzhaq/BvRPx+qqG98o3U=;
        b=CnSODYEJfT20nnoYJI0y3SE5Z8AGltYLoHOyqyUtjk6gPQv5RjaG/4AoQV+vrXl73b
         wfAYk1QULojQMv0L/zal7EiVurU4uCiBOXKoOVotAaARsbCssEbGipiaxHFrsCVklvYj
         6ZWpyAHSlgLLkLSvLTOMzEB4NxEUIGS2aO7wCie1seUXBnhW7hU/e+CqlL9DXsCHlhN5
         KXcyZLcCM4YmyEuLgPNYSXsF9yBy7AabtrRCU4gcUyuQL827sC79vX5vDGRy1xcScxvL
         DkIPM5GM03AzNDvsb5FPUtHxTIuzG3HLRwsampwbQceCQJ6YcSBxFbUIOfaEUBvO3DP/
         D7SA==
X-Forwarded-Encrypted: i=1; AJvYcCUwLQEekk4SvnzYejzwbTtUXwakJkJZPIoeZnxiz7Pl5L244MEqEs4KCphYhnxWdb98w2w/+x9xEPX8voK3@vger.kernel.org
X-Gm-Message-State: AOJu0YwvOdHnH5b5MomLyEjNmmuia/+vbeuShc+NtMXKoVwWsW6KqtEC
	vy7BHmuH3uA119GdtCZqn3YTpQ7fgZ3CGWXOLTd5EmugOBVtZN0Ny7FRftV90hjkbPzH8Y0ffz7
	d/HkOQA==
X-Google-Smtp-Source: AGHT+IHf83nSsh8dSI5MT6Lq2qwz18kf/IKNLkJKmhvyxAcTbUnK8QftG83szzLWCAGb7csPDeD/aKPeenOu
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:6902:118f:b0:e24:9584:52d3 with SMTP
 id 3f1490d57ef6-e24d71625d8mr82063276.2.1727307595844; Wed, 25 Sep 2024
 16:39:55 -0700 (PDT)
Date: Wed, 25 Sep 2024 23:38:28 +0000
In-Reply-To: <20240925233854.90072-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240925233854.90072-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240925233854.90072-14-mmaurer@google.com>
Subject: [PATCH v5 13/16] export_report: Rehabilitate script
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	Matthew Maurer <mmaurer@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, linux-modules@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>
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
2.46.1.824.gd892dcdcdd-goog

