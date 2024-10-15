Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35481FDFA9
	for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034408; cv=none; b=cxWveWsyMWrPQ6XxPowEI+Kruq0/kOsYJg7VWZAgYXkavKdrD495n/4EZ3+mqz+gMplPXTkE71ZpXOUMdzJutrXqRiiyE1z5gaO2Njy/+jVLNqegIhwfy/yWN9qm+l3Ttm6x08XOMK3fEq1c/zktVPTpdMLn/ZHbDIpTIKks6Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034408; c=relaxed/simple;
	bh=THSkSo9lSkuxsbYiUqaXJmBiMFSg1TaDfQHynW6LWoM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aJkPntjS1FH2jL+PacufWar8sjDdUvGqb+Qycb0Vu6bthzbP/ykDy4A7ow/TInbv05WK9rtJDOUlGzzUiQh1B0cc6tCz726bLxM899J9pEvWFGyF+2CRJeG4FPZtmDl0NlXIKU+8kMct/QJ0QZ3qWdbaDiuQIfATu2aAlZOqlLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DJkd1Qjd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DJkd1Qjd"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e370d76c15so51958317b3.2
        for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 16:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034406; x=1729639206; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y90q7N+0JYvarHeSSS/HcK3d00J7zzbtwQB+DjacdQs=;
        b=DJkd1Qjd6nfYoALd0SmcygiPVkhCub3F6KQlzJFaGd172PG+zHvYXrDFqdcoFw0l0z
         tWxJYs8O1wnSlt1nmB4VxN8+fUgqqTfBhiR1l2yEoKMPJWI3W59zpmOEvX9mbskJt5ZT
         nrBnDIBtqftzCfy78ruvNKuL1ztQTwLC7QLbOMYdZJn13C9pt/W4Vz+YSlZhAJocTjU2
         I7+ez/lBvnXV0i12tYHwHherRtEsaIgNIovI3jTloJGbO+ZKEPhTn4o1sBQRHEYouOfd
         1rKPDILVBOJjh8HMLJ9xvCghVD5Iw+lGW8VdhR92biWljp6a1fLZNBHKBTb1EBl1NPrF
         OwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034406; x=1729639206;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y90q7N+0JYvarHeSSS/HcK3d00J7zzbtwQB+DjacdQs=;
        b=IBnCl00pvjgYsrLL6nMiSs7bMCkqApQ5rjl2UelEEbqaMPrHQnJUi4+NUxi5QylHLC
         nqUK2uXALixrYgKreWfjkrDkepo6QjXO2pYEmNZus3qZxfUAh0qH0nTu7eBcTIVq1HIw
         P3RYB5nOkGAD+t6fFHaaLu+yIOI/K0fgiWYsZ9MBytCpHGNXxNaXjmX8f1A3gi6XkqoP
         MlcsgjTD+I+3DNkr8Ao69wWd5zKBUhmoDfiLqyIqZsa1z37I7ph7vIAoWSch8iXS0Dsk
         YI/aEHpvcoyZRgBTZiYr9i90IllvzvBAYjgQYZ8LkYA95VSjchNKQx9c+Eb56Y1OwKqE
         BdXA==
X-Forwarded-Encrypted: i=1; AJvYcCWna6KHzXixLk0cAhnhV0lIbVJTVHuKT4KyHErv6EIfW1jnp5dW/jMYmcqOLOyPTe7IDQv4Fs6l0UrTATj6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk0/0AFNjllYKnqoY5t7uhO/t01lzk5SSkkhcojHHmJGoBM8Ib
	A54YVkkl4eA1oflzBUrlpFVfe/z0uLxQ09UfMc3d9PQCuc6l3bhpqoyJ9a79/2SafVDRKy0hRZe
	MYfyfdQ==
X-Google-Smtp-Source: AGHT+IEl0PoSNMsAIV4NYkV6h7fXXICopbsvroAdggBgvaXcptZB1VvmgZiKvr9u8QtCOHgbZG9OiwkRYgC+
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:690c:9b02:b0:6e2:371f:4afe with SMTP
 id 00721157ae682-6e3d4194914mr597357b3.4.1729034405979; Tue, 15 Oct 2024
 16:20:05 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:19:00 +0000
In-Reply-To: <20241015231925.3854230-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015231925.3854230-1-mmaurer@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231925.3854230-6-mmaurer@google.com>
Subject: [PATCH v6 5/5] export_report: Use new version info format
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>
Cc: rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, neal@gompa.dev, marcan@marcan.st, j@jannau.net, 
	asahi@lists.linux.dev, linux-modules@vger.kernel.org, samitolvanen@google.com, 
	Matthew Maurer <mmaurer@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"

The new version info format has a superset of symbols in the old format.
Since this is a tool for in-tree modules, we don't need to parse the old
one with this tool any longer.

Even if we build without CONFIG_EXTENDED_MODVERSIONS, these are still in
the `.mod.c` file. Their presence in the final module is controlled by
conditional compilation inside the at file.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 scripts/export_report.pl | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/scripts/export_report.pl b/scripts/export_report.pl
index dcef915405f3..6a37df6f947f 100755
--- a/scripts/export_report.pl
+++ b/scripts/export_report.pl
@@ -114,31 +114,29 @@ foreach my $thismod (@allcfiles) {
 	}
 
 	my $state=0;
+	# State map:
+	# 0 - Looking for names
+	# 1 - Scanning names
+	# 2 - Done
 	while ( <$module> ) {
 		chomp;
 		if ($state == 0) {
-			$state = 1 if ($_ =~ /static const struct modversion_info/);
+			$state = 1 if ($_ =~ /__used __section\("__version_ext_names"\)/);
 			next;
 		}
 		if ($state == 1) {
-			$state = 2 if ($_ =~ /__used __section\("__versions"\)/);
-			next;
-		}
-		if ($state == 2) {
-			if ( $_ =~ /};/ ) {
-				$state = 3;
-				next;
-			}
-			if ( $_ !~ /0x[0-9a-f]+,/ ) {
+			if ( $_ =~ /;/ ) {
+				$state = 2;
 				next;
 			}
-			my $sym = (split /([,"])/,)[4];
+			$_ =~ /"(.*)\\0"/;
+			my $sym = $1;
 			my ($module, $value, $symbol, $gpl) = @{$SYMBOL{$sym}};
 			$SYMBOL{ $sym } =  [ $module, $value+1, $symbol, $gpl];
 			push(@{$MODULE{$thismod}} , $sym);
 		}
 	}
-	if ($state != 3) {
+	if ($state != 2) {
 		warn "WARNING:$thismod is not built with CONFIG_MODVERSIONS enabled\n";
 		$modversion_warnings++;
 	}
-- 
2.47.0.rc1.288.g06298d1525-goog

