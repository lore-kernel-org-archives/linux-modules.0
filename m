Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ECA1F80A4
	for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 23:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034399; cv=none; b=L54yKAJArt0Uo3Q6njGfxiftVLCOaK9NtgsouX+mZIrKgXKf9IEtwKB7pNsR/3cfoLCxjfuz+UiBHOmdW/L3JKdv8jNORPVJ8ucyMe5/9o7nVp32rrjd+g0OuzDVbWygr5fnbRkl18ydQSciwBgLDyoSgLqDVKxzrN5bkcS3Zno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034399; c=relaxed/simple;
	bh=b/Bd5hNVwONQMAMAKZObOat4jqHFnL5FtBWQng4HuQc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rNwq9Yi2jP5BQ/T6GIrTiSmehHCUpjhpz9pfniE7BKH5cmn+nGLzSKCmtCdRLwRJAVj1WAXcohb1192vZzb/6UlmL1hUZvFJDCDS5RLyB7nxlKpU9UNC7q+TH4Ph0dHfhlWwjdqSFlAA7e9I420ZW1AtbGdow5lPuWK1/tFqoAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N1dO/cYJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N1dO/cYJ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e292a6bdd72so6632005276.0
        for <linux-modules@vger.kernel.org>; Tue, 15 Oct 2024 16:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729034396; x=1729639196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GMeFuBGaCaHx7HaM28eyKlSyRMkG/ZUOc3U36euZD88=;
        b=N1dO/cYJgyXeHSEkWZ8PHaXrwa/kRuKQYlwroncJFvpb+qGuZlcqMJw7yzLeY03SXD
         Tf3MIpwjEaL7rtuiH2HoEPdISP63RqtNsmBauP0fjZ2ytZWbuvDpD+XpeuwdZb7Vel4m
         rwDhDnugNGydsQ1jb9+y0lEiDpgyAVIil/SrHktcGNRXQXh9H2ygeeMx7bECNdUZQcIj
         Z7/PWE5YWKimlu0XXydjHhLEDV8BRzdbczjknmDR/oFRbo29BvVQpWyMRCP1FD/p+JoX
         38hchTAzzXjhve1pzxwljmTVZxAabLdBO5rZo8/VNAbjcLY+ffYEL/sMO1vvBnP7+C1y
         Krjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034396; x=1729639196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMeFuBGaCaHx7HaM28eyKlSyRMkG/ZUOc3U36euZD88=;
        b=tgZlW83grIQLEJ68zIM+iybrmgmek9ZWe+NCjE6uK6layNFRecw0ymjHv7vJhh2yQj
         R2tznERT5uYpkXryfgWa7KKZzod+Cp4PRMIF9Ms11VkwLT2aoONpYmYocuWwI6rUoi13
         AWz7Xh1Pc5SeNEuoDnwdfCqbA2jl3i5gelABxoNZdq25lrAp1EOVckVuWxeiCEL4MyaX
         bAOcCNh0ZFD3rj4YGdsAlb4YP22tsx3u4f1dyecTyrPlvCM6+B0tsFuOQye1YNpvlMmH
         VD/EM0M/lnPY0ZHN2ZlZUZMt1vNeNC/uSUfAA6Kk4Vesf08h6MD6tSovHsJlGp9c06wX
         7L+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUflh7wewaPRtm784xgCOmXz3Lqz4K7qkqCBwCpoGK9PRZxLgxHJlQOOhdoubW1ueKkVrPsq9ktjX62OOU+@vger.kernel.org
X-Gm-Message-State: AOJu0YyHnvDEIII9Tsht4aHSQ9ZKWvlXprneOc4j6XgUdX1v/CqZ3spX
	Jl7Hx+PPk7nAGhXBfjKKkeibnXvOgrbXByq2Rx7b2OavkLY1/h5U3j2ZwVXCArSHNASPKhGaxap
	ePijm8g==
X-Google-Smtp-Source: AGHT+IHJ/PD4IZdXpfLT+phmwcv6QqIW8I80B2uJZiw7eFoWOINWL5PmPprPbPx3sBWJLPoXxBjkxCvK2VhZ
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a5b:341:0:b0:e29:68a9:8612 with SMTP id
 3f1490d57ef6-e29782f4017mr1762276.4.1729034396326; Tue, 15 Oct 2024 16:19:56
 -0700 (PDT)
Date: Tue, 15 Oct 2024 23:18:58 +0000
In-Reply-To: <20241015231925.3854230-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241015231925.3854230-1-mmaurer@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015231925.3854230-4-mmaurer@google.com>
Subject: [PATCH v6 3/5] export_report: Tolerate additional `.mod.c` content
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

Currently, `export_report.pl` will error out if it sees a hex number not
in the context of the original `__versions` array. This adds a
"finished" state so that it does not attempt to parse content past the
end of the array, and requires the array to be terminated.

This is prepwork for the subsequent extended modversions information,
which would not be parseable otherwise.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 scripts/export_report.pl | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/export_report.pl b/scripts/export_report.pl
index 30b5f7819086..dcef915405f3 100755
--- a/scripts/export_report.pl
+++ b/scripts/export_report.pl
@@ -125,6 +125,10 @@ foreach my $thismod (@allcfiles) {
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
@@ -134,7 +138,7 @@ foreach my $thismod (@allcfiles) {
 			push(@{$MODULE{$thismod}} , $sym);
 		}
 	}
-	if ($state != 2) {
+	if ($state != 3) {
 		warn "WARNING:$thismod is not built with CONFIG_MODVERSIONS enabled\n";
 		$modversion_warnings++;
 	}
-- 
2.47.0.rc1.288.g06298d1525-goog

