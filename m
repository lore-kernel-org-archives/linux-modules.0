Return-Path: <yauheni.kaliuta@redhat.com>
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: linux-modules <linux-modules@vger.kernel.org>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Mark van Dijk <linux-modules@z.dvxs.net>
Subject: [PATCH 3/4] libkmod: modinfo: implement line splitting in hex_to_str
Date: Tue, 11 Apr 2017 15:15:02 +0300
Message-Id: <20170411121503.26181-4-yauheni.kaliuta@redhat.com>
In-Reply-To: <20170411121503.26181-1-yauheni.kaliuta@redhat.com>
References: <20170411121503.26181-1-yauheni.kaliuta@redhat.com>
List-ID: <linux-modules.vger.kernel.org>

The key output is usually short, but for signature it is more
readable to output it in several lines.

Implement line splitting. Set line limit hardcoded to 20 hex
numbers (not characters).

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 libkmod/libkmod-module.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/libkmod/libkmod-module.c b/libkmod/libkmod-module.c
index 22c8f4c852a2..9e155f080277 100644
--- a/libkmod/libkmod-module.c
+++ b/libkmod/libkmod-module.c
@@ -2197,15 +2197,25 @@ static char *kmod_module_hex_to_str(const char *hex, size_t len)
 {
 	char *str;
 	int i;
+	int j;
+	const size_t line_limit = 20;
+	size_t str_len;
 
-	str = malloc(len * 3);
+	str_len = len * 3; /* XX: or XX\0 */
+	str_len += ((str_len + line_limit - 1) / line_limit - 1) * 3; /* \n\t\t */
+
+	str = malloc(str_len);
 	if (str == NULL)
 		return NULL;
 
-	for (i = 0; i < (int)len; i++) {
-		sprintf(str + i * 3, "%02X", (unsigned char)hex[i]);
-		if (i < (int)len - 1)
-			str[i * 3 + 2] = ':';
+	for (i = 0, j = 0; i < (int)len; i++) {
+		j += sprintf(str + j, "%02X", (unsigned char)hex[i]);
+		if (i < (int)len - 1) {
+			str[j++] = ':';
+
+			if ((i + 1) % line_limit == 0)
+				j += sprintf(str + j, "\n\t\t");
+		}
 	}
 	return str;
 }
-- 
2.9.2.368.g08bb350
