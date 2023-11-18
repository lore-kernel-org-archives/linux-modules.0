Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A+K7W2go"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E851723
	for <linux-modules@vger.kernel.org>; Fri, 17 Nov 2023 18:58:16 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5bc3be6a91bso29617407b3.1
        for <linux-modules@vger.kernel.org>; Fri, 17 Nov 2023 18:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700276295; x=1700881095; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6470cZa62MbyzT9ybBeTXZeWGQJ3Ep0Ies1ZAhH/GQQ=;
        b=A+K7W2goGY3rCRjchC7VMQq7Xg5AZwcYYzysdc+2u8ff3LvNEE0oRpHfJT18UQp+Tj
         Vxw/Lz5R2tV0BLDhuOImU1MSL3Eg9uhp71m6ky1ddK6jEsjTzkD5gCBFRfOYPPXMi8tD
         Vd66AYhHa+2IAEhxWB6Gp5C7k+eWK6MqJYDmh840RN97lJz+JqpDREwsU3HbnR2k/nez
         EikZnDIXaXE3L4gBVpvI3eGFXzYY/imHZ0LocduIXhhiYQLeOl6cz68zvws80d2rreEo
         P2lkWaIIOGoQCq8prnhBAGj67Bn4bNAxq4u8hvkakG8K4fXsd5SbazKYGcAstfApcoJe
         6JEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700276295; x=1700881095;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6470cZa62MbyzT9ybBeTXZeWGQJ3Ep0Ies1ZAhH/GQQ=;
        b=lgrR5yV0A6W7nmt9x6vCLDJ9VgyLcv3johGvf0WbvbfImHLUbAkm9NWSyvvzfP/jgG
         B+jhRY+fW9hzcROVZvzJh9ex0ZhCY/yqlZBvF6O3UIvGlOw7GJCDrldPYxMKqrgFvaBC
         +ZC3b+AdhxWqL5VwCofOwdrS/qJmakYBMyceDxTrGgnu8Jf3dFQIkrn0KTWanuFQabvI
         vYPLPmMpbzbECZzochwdns388gwA6twiae3Xd9sMVSU6vbVpTdWgnDYjqLn1MRbiw2Nv
         7KB07NHHZaAZlG6CAsoIBSyZq+d9M0xjlk9smhbUWXT00K18vvOUQ9MbSk1RJXwHDJuA
         pF3A==
X-Gm-Message-State: AOJu0Yx35LGBErElBRlVRpPzPBa82IAs77xi3+1FY0toyOeFKk4w80fR
	aiCXk2+Ns00HcS6ptcrLwZkLJHtV62nb
X-Google-Smtp-Source: AGHT+IE0p+YtnUfNXyViuu9ji/lc0sYzrwa5eOwzdtBv1fKlqv6arjeB7wtV3bdeWily94YGEBFtqUBG97qg
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a5b:cc9:0:b0:da0:37e1:558e with SMTP id
 e9-20020a5b0cc9000000b00da037e1558emr26098ybr.6.1700276295405; Fri, 17 Nov
 2023 18:58:15 -0800 (PST)
Date: Sat, 18 Nov 2023 02:54:46 +0000
In-Reply-To: <20231118025748.2778044-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231118025748.2778044-1-mmaurer@google.com>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
Message-ID: <20231118025748.2778044-6-mmaurer@google.com>
Subject: [PATCH v2 5/5] export_report: Use new version info format
From: Matthew Maurer <mmaurer@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Luis Chamberlain <mcgrof@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Laura Abbott <laura@labbott.name>, Matthew Maurer <mmaurer@google.com>
Content-Type: text/plain; charset="UTF-8"

The new version info format has a superset of symbols in the old format.
Since this is a tool for in-tree modules, we don't need to parse the old
one with this tool any longer.

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
2.43.0.rc0.421.g78406f8d94-goog

