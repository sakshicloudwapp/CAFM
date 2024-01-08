import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fm_pro/global/colortheme.dart';
import 'package:fm_pro/services/allApiServices.dart';
import 'package:fm_pro/services/webservices.dart';
import 'package:fm_pro/utils/customLoader.dart';
import 'package:fm_pro/utils/dark_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'dart:convert' as convert;
import '../../global/my_string.dart';

class TermAndConditionsScreen extends StatefulWidget {
  String title;

  TermAndConditionsScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<TermAndConditionsScreen> createState() =>
      _TermAndConditionsScreenState();
}

class _TermAndConditionsScreenState extends State<TermAndConditionsScreen> {
  var data = r""" <div>
    <p style="margin-top:0pt; margin-bottom:8pt;">&nbsp;</p>
    <table cellspacing="0" cellpadding="0" style="border:0pt solid #000000; border-collapse:collapse;">
        <tbody>
            <tr>
                <td style="padding-right:5.03pt; padding-left:5.03pt; vertical-align:top;">
                    <p style="margin-top:0pt; margin-bottom:0pt; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; font-size:11pt;"><strong>Terms of Use</strong></p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">This Terms of Use agreement was executed on 21/6/2021 and remains in effect. By using the PropEzy app (&quot;App&quot; or &quot;Platform&quot;) or any of the services provided by East-O Holdings Limited (&quot;East-O Holdings Limited&quot;, &quot;we&quot;, &quot;us&quot;, or &quot;our&quot;), including, but not limited to any of the services offered on www.propezy.com or by Propezy (collectively the app, platform and services herein referred to as the &quot;Services&quot;), you, on behalf of yourself as an individual as well as on behalf of the party who has entered into a subscription agreement with PropEzy, to grant you access to the Services, are agreeing to be bound by the following terms and conditions (&quot;Terms of Use&quot;). If you do not wish to be bound by these Terms of Use, please exit the App now and do not use any of the Services. Your agreement with us regarding compliance with these Terms of Use becomes effective immediately upon commencement of your use of the App or Services. We expressly reserve the right to change these Terms of Use from time to time upon reasonable notice to you (including without limitation via electronic notification or notification on the Site). You agree that it is your responsibility to review these Terms of Use from time to time and to familiarize yourself with any modifications. Your continued use of this App or any Services after notification of such modifications will constitute acknowledgement of the modifications and agreement to abide and be bound by the revised Terms of Use. Violation of any of the terms below will result in the suspension or termination of your account without a right to any refund if you have subscribed to any paid Services.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;"><strong>1. ACCOUNT REQUIREMENTS</strong></p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">The only individuals who shall be permitted to use the Platform / Services are:</p>
                    <ol type="a" style="margin:0pt; padding-left:0pt;">
                        <li style="margin-left:31.05pt; text-align:justify; padding-left:4.95pt; font-size:11pt;">actual property Landlords; and</li>
                        <li style="margin-left:31.56pt; text-align:justify; padding-left:4.44pt; font-size:11pt;">actual property Tenants; and</li>
                        <li style="margin-left:30.43pt; text-align:justify; padding-left:5.57pt; font-size:11pt;">actual property management agents appointed by Landlords.</li>
                    </ol>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">To register for the Services, you must provide the information requested (which may include such items as your legal full name, a valid email address for you, a valid phone number for you, and other information, and which may be collected through a third party service, and you hereby authorize us to collect such data) (the &quot;Registration Data&quot;). If you are a company with multiple individuals, each person must have their own login - a single login may not be shared by multiple people. The information we obtain through your use of the Services, including your Registration Data, is subject to our privacy policy, which is available in the App. You agree that you, as an individual as well as the party who employs you or otherwise authorized your access to the Services under a separate agreement with East-O Holdings Limited are each jointly and severally responsible for all activities that occur under your user account.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">You agree not to use the account, username or password of another user at any time or to do anything else that might jeopardize the security of your or another user&apos;s account. You agree to notify us immediately of any unauthorized use of your account. If we have reasonable grounds to suspect violation of these terms or that registration information you have provided is untrue, inaccurate, outdated, or incomplete, we may terminate your account without refund (where applicable) and refuse current or future use of any or all of the Services. We are not responsible for any loss or damage to you or any third party that may be incurred as a result of any unauthorized access and/or use of your account, or otherwise.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">You, as an individual, as well as the party who employs you or has otherwise authorized you to access the Services under a separate agreement with East-O Holding Limited will be responsible for maintaining the security of your account, passwords (including but not limited to administrative and user passwords) and files, and for all uses of your personal account and any of your uses or misuses of the responsible organization&apos;s account.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;"><strong>2. DESCRIPTION OF OUR SERVICES</strong></p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">General:</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">Through PropEzy, East-O Holdings Limited provides a suite of Services defined as below:</p>
                    <ol type="a" style="margin:0pt; padding-left:0pt;">
                        <li style="margin-left:31.05pt; text-align:justify; padding-left:4.95pt; font-size:11pt;">Community Management: a platform for managing communications and services by property/community managers, aimed at landlords &amp; tenants.</li>
                        <li style="margin-left:31.56pt; text-align:justify; padding-left:4.44pt; font-size:11pt;">Facility Management: a platform for managing communications and services by Facilities Team, aimed at landlords, tenants &amp; clients.</li>
                        <li style="margin-left:30.43pt; text-align:justify; padding-left:5.57pt; font-size:11pt;">Asset Management: a platform for managing real estate asset portfolios</li>
                        <li style="margin-left:31.56pt; text-align:justify; padding-left:4.44pt; font-size:11pt;">Permit to Work: a platform for managing site work permits</li>
                    </ol>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">All of the above are integrated with each other. Depending on the access available to you, you may use any one or all of the Services.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">We reserve the sole right to either modify or discontinue the Services or features that might be available at any time with or without notice to you. Any modified or new features that we may choose to make available to you shall also be subject to these Terms of Use.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;"><strong>3. CONDUCT WHEN USING THE PLATFORM AND SERVICES</strong></p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">Your use of the Services is subject to all applicable laws and regulations, as well as the applicable terms of any third party integrated with our service, and you are solely responsible to ensure that your use of the Services complies therewith. Please pay close attention to any third party terms that you have agreed to, including those posted within third party services. Your use of the Services is at your sole risk and is provided on an &quot;as is&quot; and &quot;as available&quot; basis. You must not modify, adapt or hack the Services or modify another website so as to falsely imply that it is associated with the Services or East-O Holdings Limited. You will not to reproduce, duplicate, copy, sell, resell or exploit any portion of the Services, use of the Services, or access to the Service without the express written permission by East-O Holdings Limited. The Services may not be used in connection with promoting anything, which in East-O Holdings Limited&apos;s sole discretion is, harmful, hateful, obscene, or unlawful. You must not use the Platform or Services to transmit any worms, viruses or any code of a destructive nature.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;"><strong>4. CONTENT RIGHTS</strong></p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">Any intellectual property rights that you have with respect to any User Content you store on our Services, or which you may deliver to us for use in connection with the Services (which for purposes of this Content Rights section is hereby included in the definition of User Content) remains yours. You grant us a non-exclusive, world-wide, fully-paid up, sub-licensable, transferable, limited license to access, copy, modify, use, distribute, store, transmit, reformat, list information regarding, edit, translate, make derivative works of, publicly display and publicly perform such User Content to the extent needed to provide our Services to you. The license you grant us is non-exclusive (meaning you are free to license your User Content to anyone else in addition to East-O Holdings Limited), fully-paid and royalty-free (meaning that we are not required to pay you for the use on the Services of the User Content that you post), transferable and sub-licensable (so that we are able to use our affiliates and subcontractors such as Internet content delivery networks to provide the Services), and worldwide (because the Internet and the Services are global in reach).</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">All intellectual property rights to content created by us, whether or not it was made available to you or published for you pursuant to the Services or otherwise, to the extent that it is not User Content is strictly ours (&quot;East-O Holdings Limited Content&quot;). We grant you a limited, non-exclusive (meaning we are free to license our East-O Holdings Limited Content to anyone else in addition to you), non-transferable and non-sub-licensable license to access, modify, use, transmit, reformat, and edit the East-O Holdings Limited Content to the extent needed solely using the Services.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;"><span style="font-family:'Times New Roman';">﻿</span>You are solely responsible for your User Content and the consequences of its transmission. You are further responsible for ensuring that you do not make any private content publicly available in violation of anyone&apos;s privacy or confidentiality rights. Any third party content that you may receive through the use of the Services from your customers or otherwise is provided to you via the Services is provided AS IS for your information and personal use only and you agree not to use or otherwise exploit such content for any purpose without the express written consent of the person who owns the rights to such content. We make no warranties, express or implied, as to the third party content or to the accuracy or reliability of the third party content or any material or information that you receive through our Services.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">You agree not to use, display or share your User Content or East-O Holdings Limited Content or any data we provide you (collectively, &quot;User Data&quot;) in a manner inconsistent with these Terms of Use, and all applicable laws and regulations. We are not required to keep back-up copies of User Data on the App once your account or User Data is deleted. We make no guarantee that User Data will be safely stored on the App. To be safe, you should independently back-up your User Data, to the extent permitted herein and by applicable laws and regulations. You acknowledge that we may terminate the account of any User in accordance with these Terms of Use.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">By posting User Content through the Services, you agree that you will not upload, share, post, or otherwise distribute or facilitate distribution of any content including text, communications, software, images, sounds, data, or other information - that:</p>
                    <ol type="a" style="margin:0pt; padding-left:0pt;">
                        <li style="margin-left:31.05pt; text-align:justify; padding-left:4.95pt; font-size:11pt;">is unlawful, threatening, abusive, harassing, defamatory, libelous, deceptive, fraudulent, invasive of another&apos;s privacy, tortious, contains explicit or graphic descriptions or accounts of sexual acts (including but not limited to sexual language of a violent or threatening nature directed at another individual or group of individuals);</li>
                        <li style="margin-left:31.56pt; text-align:justify; padding-left:4.44pt; font-size:11pt;">victimizes, harasses, degrades, or intimidates an individual or group of individuals on the basis of religion, gender, sexual orientation, race, ethnicity, age, or disability;</li>
                    </ol>
                    <p style="margin-top:0pt; margin-left:36pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">infringes on any patent, trademark, trade secret, copyright, right of publicity, or other proprietary right of any party;</p>
                    <ol start="3" type="a" style="margin:0pt; padding-left:0pt;">
                        <li style="margin-left:30.43pt; text-align:justify; padding-left:5.57pt; font-size:11pt;">constitutes unauthorized or unsolicited advertising, junk or bulk email (also known as &quot;spamming&quot;), chain letters, any other form of unauthorized solicitation, or any form of lottery or gambling;</li>
                        <li style="margin-left:31.56pt; text-align:justify; padding-left:4.44pt; font-size:11pt;">contains software viruses or any other computer code, files, or programs that are designed or intended to disrupt, damage, or limit the functioning of any software, hardware, or telecommunications equipment or to damage or obtain unauthorized access to any data or other information of any third party; or</li>
                        <li style="margin-left:31.25pt; text-align:justify; padding-left:4.75pt; font-size:11pt;"><span style="font-family:'Times New Roman';">﻿</span>impersonates any person or entity, including any of its employees or representatives.</li>
                    </ol>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">We neither endorse nor assume any liability for any User Content. However, we and our agents have the right in our sole discretion to remove any User Content that, in our judgment, does not comply with these Terms of Use or any other rules of user conduct for the Services, or is otherwise harmful, objectionable, or inaccurate. We are not responsible for any failure or delay in removing such content. You hereby consent to such removal and waive any claim against us arising out of such removal of User Content.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">While you retain all of your pre-existing rights in the User Content, you grant us and our agents and affiliates a non-exclusive, paid-up, perpetual, and worldwide right to copy, distribute, display, perform, publish, translate, adapt, modify, and otherwise use such materials for any purpose regardless of the form or medium (now known or not currently known) in which it is used, including but not limited to, display through the Services, and display on the App for the purpose of demonstrating how our Services can be used. You shall be solely responsible to make and retain any copies of the User Content you need for your purposes before your account is terminated.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;"><strong>5. THIRD PARTY SERVICES AVAILABLE ON THE PLATFORM</strong></p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">In Classifieds module, users may meet and interact with one another for the purpose of exchanging goods &amp; services. In Marketplace module, users may interact with advertisers for goods and services.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">Users shall independently agree between themselves upon the manner and terms and conditions of delivery, payment, etc in respect of any Services and PropEzy holds no responsibility in respect of such arrangements;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">PropEzy is not and cannot be a party to or control in any manner any transaction between two Users of the Platform and cannot guarantee that a User, Advertiser or any third party service provider will complete a transaction or accept the return of a service or provide any refund for the same.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">You will not hold PropEzy responsible for other Users&apos; advertisement content, actions, or inactions, or Services or information which they list, post, provide or purport to offer or provide.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">The Platform may include links to third party websites that are controlled by and maintained by others. PropEzy cannot accept any responsibility for the materials or offers for services featured on such websites and any link to such websites is not an endorsement of such websites or a warranty that such websites will be free of viruses or other such services of a destructive nature and you acknowledge and agree that PropEzy is not responsible for the content or availability of any such sites. <span style="font-family:'Times New Roman';">﻿</span></p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">PropEzy accepts no liability for any errors or omissions, whether on behalf of itself or third parties;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">To the extent permitted by law, PropEzy excludes all implied warranties, terms and conditions and is not liable for any loss of money, goodwill or reputation, or any special, indirect or consequential damages arising directly or indirectly, out of your use of or your inability to use the Platform.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;"><strong>6. CANCELLATION AND TERMINATION</strong></p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">Upon cancellation of any account, all of the content you have created and posted through the Services (&quot;User Content&quot;) may be immediately deleted and may not be recovered once your account is cancelled. We do not accept any liability for loss of your User Content due to cancellation of your account. If you cancel the Service before the end of your current paid up license period, your cancellation will immediately take effect and you will not be charged again after the current license period has ended, but there are no refunds for early termination.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">We further reserve the right to disable or deactivate unpaid accounts. In the event of such termination, all data associated with such an account may be deleted. We are not obligated to provide you prior notice of such termination.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;"><strong>7. PLATFORM &amp; SOFTWARE RIGHTS</strong></p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">You will not, and will not allow any third party to: reverse engineer, decompile, disassemble or otherwise attempt to discover the source code, object code or underlying structure, ideas or algorithms of the Platform or any software, documentation or data related to the Platform (&quot;Software&quot;) (provided that reverse engineering is prohibited only to the extent such prohibition is not contrary to applicable law); modify, translate, or create derivative works based on the Platform or Software; use the Platform or Software other than for your internal benefit; use the Platform or Software other than in accordance with these Terms of Use or any other written agreement with respect to the subject matter hereof or in compliance with all applicable laws and regulations, including but not limited to any privacy laws, and laws or regulations concerning intellectual property, consumer and child protection, obscenity or defamation.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">Except as expressly set forth herein, East-O Holdings Limited alone will retain all intellectual property rights relating to the Platform or the Software, as well as any suggestions, ideas, enhancement requests, feedback, recommendations or other information provided by you or any other party relating to the Platform and/or the Software, which are hereby assigned by you to East-O Holdings Limited. <span style="font-family:'Times New Roman';">﻿</span></p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;"><strong>8. ELECTRONIC COMMUNICATIONS</strong></p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">By using the Service, you consent to receiving electronic communications from PropEzy. These electronic communications may include notices about App services, transactional information and other information concerning or related to your use of the Service. These electronic communications are part of your relationship with PropEzy and you receive them as part of your access and use of the Service. You agrees that any notices, agreements, disclosures or other communications that PropEzy sends you electronically will satisfy any legal communication requirements, including that such communications be in writing.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;"><strong>9. DISCLAIMER OF WARRANTIES</strong></p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">All materials, content, and services are provided on an &quot;as is&quot; and &quot;as available&quot; basis without warranty of any kind, either express or implied, including, but not limited to, the implied warranties of merchantability or fitness for a particular purpose, or the warranty of non-infringement. Without limiting the foregoing, we make no warranty that (a) the services will meet your requirements, (b) the services will be uninterrupted, timely, secure, or error-free, (c) the results that may be obtained from the use of the services will be effective, accurate or reliable, or (d) the quality of any services or information purchased or obtained by you from us or our affiliates will meet your expectations or be free from mistakes, errors or defects.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">This app could include technical or other mistakes, inaccuracies or typographical errors. We may make changes to the materials and services within the app, including the prices and descriptions of any products or services listed herein, at any time without notice. The materials or services within this app may be out of date, and we make no commitment to update such materials or services.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">The use of the services is done at your own discretion and risk and with your agreement that you will be solely responsible for any damage to your computer system or loss of data that results from such activities. <span style="font-family:'Times New Roman';">﻿</span></p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;"><strong>10. LIMITATION OF LIABILITY</strong></p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">You expressly understand and agree that East-O Holdings Limited shall not be liable for any indirect, punitive, incidental, special, consequential or exemplary damages, including but not limited to, damages for loss of profits, goodwill, use, data or other intangible, resulting from any cause including: (i) the use or the inability to use the Service; (ii) the cost of procurement of substitute goods and services resulting from any goods, data, information or services purchased or obtained or messages received or transactions entered into through or from the Service; (iii) unauthorized access to or alteration of your transmissions or data; (iv) statements or conduct of any third party on the Service; (v) or any other matter relating to the Service.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">The total liability of East-o Holdings Limited, whether based in contract, tort (including negligence or strict liability), or otherwise, will not exceed the lesser of one thousand dollars ($1,000 or local currency equivalent), or the aggregate of the fees paid to East-O Holdings Limited hereunder in the twelve month period ending on the date that a claim or demand is first asserted, whichever is less. The foregoing limitations will apply notwithstanding any failure of essential purpose of any limited remedy.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;"><strong>11. INDEMNIFICATION</strong></p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">You agree to defend, indemnify, and hold East-O Holdings Limited, our staff (officers, directors, employees and agents) harmless from all liabilities, claims, and expenses, including attorney&apos;s fees that arise from your use or misuse of the App or Services. We reserve the right, at our own expense, to assume the exclusive defense and control of any matter otherwise subject to indemnification by you, in which event you will cooperate with us in asserting any available defenses.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;"><strong>12. GOVERNING LAW</strong></p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">These Terms of Use are controlled by us from our offices within Abu Dhabi Global Market (ADGM) in United Arab Emirates. By accessing the Services, we both agree that the statutes and regulations of the ADGM, without regard to (i) the conflicts of laws principles thereof and (ii) the United Nations Convention on the International Sales of Goods, will apply to all matters relating to the use of the Services. Any dispute, controversy or claim arising out of or relating to this contract, including the formation, interpretation, breach or termination thereof, including whether the claims asserted are to be handled in line with the Governing laws and Regulations for ADGM. <span style="font-family:'Times New Roman';">﻿</span></p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;"><strong>13. MISCELLANEOUS</strong></p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">East-O Holdings Limited holds the complete IP Rights of the Platform / Services, including all copyright, database rights, rights in registered and unregistered trademarks and designs, service marks, registered design rights, patents, know- how and any other similar rights, and any other intellectual property rights and any applications for registration of any such right, and the right to make any such applications, in each case in any part of the world, and all related goodwill; The software that runs the Services and look and feel of the Services is a copyright 2021 of East-O Holdings Limited. All rights reserved. You may not duplicate, copy, or reuse any portion of the HTML/CSS or visual design elements without express written permission from East-O Holdings Limited.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">The failure of East-O Holdings Limited to exercise or enforce any right or provision of the Terms of Use shall not constitute a waiver of such right or provision. The Terms of Use, coupled with any legally executed pricing terms and modifications, constitutes the entire agreement between you and East-O Holdings Limited and govern your use of the Service, which supersedes any prior agreements between you and East-O Holdings Limited.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">You understand that East-O Holdings Limited uses third party vendors and hosting partners to provide the necessary hardware, software, networking, storage, and related technology required to run the Services and East-O Holdings Limited is not responsible for the shortcomings of any such third parties.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;"><strong>14. CONTACT US</strong></p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">&nbsp;</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; text-align:justify; font-size:11pt;">This platform is owned and operated by East-O Holdings Limited. If you have any question about these Terms, or to report any suspected fraudulent or misleading content or practices on the platform, please contact us on <a href="mailto:wecare@propezy.com" style="text-decoration:none;"><u><span style="color:#0563c1;">wecare@propezy.com</span></u></a>.</p>
                    <p style="margin-top:0pt; margin-bottom:0pt; font-size:11pt;">&nbsp;</p>
                </td>
            </tr>
        </tbody>
    </table>
</div>""";


  var privecy_data = "";

  bool is_loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApi();
  }

  //var HtmlCode = data ;

  getApi() async {
    if(widget.title == "Terms & Conditions"){
      await RequestGetTermsAndCondtions(context);
      setState(() {});
    }else{
      await RequestPrivecypolicy(context);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
    return MediaQuery(
      data: data,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor:
                  context.isDarkMode ? myColors.app_theme : myColors.app_theme,
              // Status bar brightness (optional)
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark, // For iOS (dark icons)
            ),
            automaticallyImplyLeading: false,
            backgroundColor: myColors.app_theme,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: myColors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              widget.title,
              style: TextStyle(color: myColors.white, fontSize: 18),
            ),
          ),
        ),
        body: privecy_data == "" ?  Container(
            height:MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.10),

            child: Center(child: CircularProgressIndicator(color: myColors.app_theme,))) :
        Stack(
          children: [

            bodyWidget(),
            is_loading == true?
            Container(
                height:MediaQuery.of(context).size.height,
                color: Colors.black.withOpacity(0.10),
                child: Center(child: CircularProgressIndicator(color: myColors.app_theme,))):Container()
          ],
        )
        
      ),
    );
  }

  /// Widget Body ui////........
  bodyWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.only(bottom: 30),
      height: MediaQuery.of(context).size.height,
      child: WebViewPlus(
        onPageStarted: (src){
          is_loading = true;
          setState(() {});
        },
        onProgress: (src){
          is_loading = true;
          setState(() {});
        },
        onPageFinished: (src){
          is_loading = false;
          setState(() {});
        },
       // javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          controller.loadString(privecy_data);
          // widget.title == "Terms & Conditions" ? data :
        },
      ),
    );
  }

  /// Term conditions.......
  Future<void> RequestGetTermsAndCondtions(BuildContext context) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    try {
      is_loading = true;
      var headers = {
        'Authorization':
            'Bearer ${p.getString("access_token")}'
      };
      var request = http.Request(
          'GET',
          Uri.parse(main_base_url + AllApiServices.GetTermsAndCondtions));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      is_loading = false;
      if (response.statusCode == 200) {
        await response.stream.bytesToString().then((value) {
          print("value ${value}");
          data = value.toString();
          privecy_data = value.toString();
          print("data${data}");

          setState(() {});
        });
      } else {
        await response.stream.bytesToString().then((value) {
          print("value3234${value}");

          privecy_data = value;
          setState(() {});

          setState(() {});
          //print("kjgbjfhgkj"+await response.stream.bytesToString());
          // print("data"+ data);
        });
      }
      // else {
      //   print(response.reasonPhrase);
      // }
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return;
  }

  Future<void> RequestPrivecypolicy(BuildContext context) async {
    SharedPreferences p = await SharedPreferences.getInstance();
    try {
      is_loading = true;
      //CustomLoader.showAlertDialog(context, true);
      var headers = {
        'Authorization':
        'Bearer ${p.getString("access_token")}'
      };
      var request = http.Request(
          'GET',
          Uri.parse(main_base_url + AllApiServices.GetPrivacyPolicy));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      is_loading = false;
      // CustomLoader.showAlertDialog(context, false);
      if (response.statusCode == 200) {
        await response.stream.bytesToString().then((value) {
          print("value ${value}");
          privecy_data = value.toString();
          print("datagnhjjh${privecy_data}");

          setState(() {});
        });
      } else {
        await response.stream.bytesToString().then((value) {
          print("value3234${value}");

          privecy_data = value.toString();
          print("datagjh${privecy_data}");
          setState(() {});
          var jsonResponse = json.decode(response.statusCode.toString());
          //  data = await response.stream.bytesToString().toString();
          setState(() {});
          //print("kjgbjfhgkj"+await response.stream.bytesToString());
          // print("data"+ data);
        });
      }
      // else {
      //   print(response.reasonPhrase);
      // }
    } on SocketException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return;
  }
}
