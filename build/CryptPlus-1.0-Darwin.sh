#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the CryptPlus-1.0-Darwin subdirectory
  --exclude-subdir  exclude the CryptPlus-1.0-Darwin subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "CryptPlus Installer Version: 1.0, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
OpenSSL is available under version 2 of the Apache License, given below:

-------------------

Apache License
Version 2.0, January 2004
http://www.apache.org/licenses/

TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

1. Definitions.

"License" shall mean the terms and conditions for use, reproduction, and distribution as defined by Sections 1 through 9 of this document.

"Licensor" shall mean the copyright owner or entity authorized by the copyright owner that is granting the License.

"Legal Entity" shall mean the union of the acting entity and all other entities that control, are controlled by, or are under common control with that entity. For the purposes of this definition, "control" means (i) the power, direct or indirect, to cause the direction or management of such entity, whether by contract or otherwise, or (ii) ownership of fifty percent (50%) or more of the outstanding shares, or (iii) beneficial ownership of such entity.

"You" (or "Your") shall mean an individual or Legal Entity exercising permissions granted by this License.

"Source" form shall mean the preferred form for making modifications, including but not limited to software source code, documentation source, and configuration files.

"Object" form shall mean any form resulting from mechanical transformation or translation of a Source form, including but not limited to compiled object code, generated documentation, and conversions to other media types.

"Work" shall mean the work of authorship, whether in Source or Object form, made available under the License, as indicated by a copyright notice that is included in or attached to the work (an example is provided in the Appendix below).

"Derivative Works" shall mean any work, whether in Source or Object form, that is based on (or derived from) the Work and for which the editorial revisions, annotations, elaborations, or other modifications represent, as a whole, an original work of authorship. For the purposes of this License, Derivative Works shall not include works that remain separable from, or merely link (or bind by name) to the interfaces of, the Work and Derivative Works thereof.

"Contribution" shall mean any work of authorship, including the original version of the Work and any modifications or additions to that Work or Derivative Works thereof, that is intentionally submitted to Licensor for inclusion in the Work by the copyright owner or by an individual or Legal Entity authorized to submit on behalf of the copyright owner. For the purposes of this definition, "submitted" means any form of electronic, verbal, or written communication sent to the Licensor or its representatives, including but not limited to communication on electronic mailing lists, source code control systems, and issue tracking systems that are managed by, or on behalf of, the Licensor for the purpose of discussing and improving the Work, but excluding communication that is conspicuously marked or otherwise designated in writing by the copyright owner as "Not a Contribution."

"Contributor" shall mean Licensor and any individual or Legal Entity on behalf of whom a Contribution has been received by Licensor and subsequently incorporated within the Work.

2. Grant of Copyright License. Subject to the terms and conditions of this License, each Contributor hereby grants to You a perpetual, worldwide, non-exclusive, no-charge, royalty-free, irrevocable copyright license to reproduce, prepare Derivative Works of, publicly display, publicly perform, sublicense, and distribute the Work and such Derivative Works in Source or Object form.

3. Grant of Patent License. Subject to the terms and conditions of this License, each Contributor hereby grants to You a perpetual, worldwide, non-exclusive, no-charge, royalty-free, irrevocable (except as stated in this section) patent license to make, have made, use, offer to sell, sell, import, and otherwise transfer the Work, where such license applies only to those patent claims licensable by such Contributor that are necessarily infringed by their Contribution(s) alone or by combination of their Contribution(s) with the Work to which such Contribution(s) was submitted. If You institute patent litigation against any entity (including a cross-claim or counterclaim in a lawsuit) alleging that the Work or a Contribution incorporated within the Work constitutes direct or contributory patent infringement, then any patent licenses granted to You under this License for that Work shall terminate as of the date such litigation is filed.

4. Redistribution. You may reproduce and distribute copies of the Work or Derivative Works thereof in any medium, with or without modifications, and in Source or Object form, provided that You meet the following conditions:

You must give any other recipients of the Work or Derivative Works a copy of this License; and
You must cause any modified files to carry prominent notices stating that You changed the files; and
You must retain, in the Source form of any Derivative Works that You distribute, all copyright, patent, trademark, and attribution notices from the Source form of the Work, excluding those notices that do not pertain to any part of the Derivative Works; and
If the Work includes a "NOTICE" text file as part of its distribution, then any Derivative Works that You distribute must include a readable copy of the attribution notices contained within such NOTICE file, excluding those notices that do not pertain to any part of the Derivative Works, in at least one of the following places: within a NOTICE text file distributed as part of the Derivative Works; within the Source form or documentation, if provided along with the Derivative Works; or, within a display generated by the Derivative Works, if and wherever such third-party notices normally appear. The contents of the NOTICE file are for informational purposes only and do not modify the License. You may add Your own attribution notices within Derivative Works that You distribute, alongside or as an addendum to the NOTICE text from the Work, provided that such additional attribution notices cannot be construed as modifying the License.
You may add Your own copyright statement to Your modifications and may provide additional or different license terms and conditions for use, reproduction, or distribution of Your modifications, or for any such Derivative Works as a whole, provided Your use, reproduction, and distribution of the Work otherwise complies with the conditions stated in this License.

5. Submission of Contributions. Unless You explicitly state otherwise, any Contribution intentionally submitted for inclusion in the Work by You to the Licensor shall be under the terms and conditions of this License, without any additional terms or conditions. Notwithstanding the above, nothing herein shall supersede or modify the terms of any separate license agreement you may have executed with Licensor regarding such Contributions.

6. Trademarks. This License does not grant permission to use the trade names, trademarks, service marks, or product names of the Licensor, except as required for reasonable and customary use in describing the origin of the Work and reproducing the content of the NOTICE file.

7. Disclaimer of Warranty. Unless required by applicable law or agreed to in writing, Licensor provides the Work (and each Contributor provides its Contributions) on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied, including, without limitation, any warranties or conditions of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE. You are solely responsible for determining the appropriateness of using or redistributing the Work and assume any risks associated with Your exercise of permissions under this License.

8. Limitation of Liability. In no event and under no legal theory, whether in tort (including negligence), contract, or otherwise, unless required by applicable law (such as deliberate and grossly negligent acts) or agreed to in writing, shall any Contributor be liable to You for damages, including any direct, indirect, special, incidental, or consequential damages of any character arising as a result of this License or out of the use or inability to use the Work (including but not limited to damages for loss of goodwill, work stoppage, computer failure or malfunction, or any and all other commercial damages or losses), even if such Contributor has been advised of the possibility of such damages.

9. Accepting Warranty or Additional Liability. While redistributing the Work or Derivative Works thereof, You may choose to offer, and charge a fee for, acceptance of support, warranty, indemnity, or other liability obligations and/or rights consistent with this License. However, in accepting such obligations, You may act only on Your own behalf and on Your sole responsibility, not on behalf of any other Contributor, and only if You agree to indemnify, defend, and hold each Contributor harmless for any liability incurred by, or claims asserted against, such Contributor by reason of your accepting any such warranty or additional liability.

END OF TERMS AND CONDITIONS

____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the CryptPlus will be installed in:"
    echo "  \"${toplevel}/CryptPlus-1.0-Darwin\""
    echo "Do you want to include the subdirectory CryptPlus-1.0-Darwin?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/CryptPlus-1.0-Darwin"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +205 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the CryptPlus-1.0-Darwin"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
� �s�e �}	`E��$!�#꠨�(��pz�`��Y��$$Dr��8�(!D��"^�f��x�� V!*��;�~]WeuT�x@��^��������������WǫW��^]ݽ��x4����n��n.馦�Xz�����6.e�X�͞�2.m,���ތ	SQV�[
�����G��.��-�p�K���SK�{ʝ�e��/صyD��4�شq���2�?=--���]ˆ��?^���_�Sb�w7�}���c�����mQs��:��5!�3�q+��U�^�����Fɫ�8VK7�y���*+�XP���A�^f�c�$�n����\�eynO��<w��ޕ[�;*)�-,�q����K���o˳ҵ��j��]��������%&��^��=6�#�'�u�ɜ<w�k깳�%5E� ׀c�B�`VL�H�o������h��/�`=_Z�=_��K�[�k�+�^�k�2�Wҙ9}�G�tU�j����k�W	�a�D�d�F�'�|qxU�"�}'�C��TX}_Yׂfc���0�&���`���C4P������P޶�������GgA��;���O5~V�h*���2�A)-��7�T9s2��E5�$OAK�SY��+�JG����.�u��f��6OH��1�p��Ν���9��R(A�F�"�r��8c���e��Ӧh+�D�߿@aMP������&j�&j�&j�&j�&j�&j�&j�&j�&j�&j�&j�&j�&j�5����z�5�ze[V��-�����W1�U��?�:!k���K��t�74��6�B{{�#�^]�G�5�T��_.(�����
?*@w!�Ӓ�]�WGۚU3�쓵#��?T�ZyԌ�; h���wqqL���w\�_t-��<b*������,�~sHe��i�e�P��� ����Wnɪ���P���o�Z�K �F��6�3�W�#��}��j>)� V��5w>lD��L6���V��u�]�p�ǲ�TU$`m��7geOQ	t�-�
t:�[ݜU=�W;>�3��a3x`�L����Y�l�bG��'�[�,�J��B�Շ���l�f��D��G���נ E%�A�;y���Y�q�
�ƃd� ���l�~���o��־EI�Mt� �6jW6g���Q&� �x�/��F�NE3_��ܢ��|�}�o}��j�{%AZ�;X��0Gt)�j����5���_?���?�G�r�?�q�>V����amWlʪ��%�z��]'��Z~�ش�D�SӮW�:��s���ŷ{Q
���b����h�[�A��1�Wl�f��o�
4~�Zj�Wɶ���(?�
���񱫂�����iɭՎ��\h�8��q����-�u!�^�C��z�}�`Ob8��Nq�ie+��b0և�(d^v��f^9]�,+�	�����5��h�Y�wZ�ޠ�h"��(t��j�ߐPv��î�ƒ��P��D<��=��M���5�+��*]��΂&���o�lF�O��O��w^��-|���̷�L�f����Ħ�p���x�]��$��FJE����s�G����-�`��0#R}�o���,:��	!u��U���`(�ؕ�@1�H�6}��B߱ 	?��M@,b�:㰪b�UT�WQU�i��xl%�����Z�i}���(o�Aޭ�楟d/T����ڕȱ�9[�媧�1�gJ&��}�������g�-�nТvhB�Z���B��R�C���?G���K����,�_��p]Y�2l�xh=�~�Դj�� ���)K`~~�C���
C��']̋&���W�M����$�tl�x_���/8(��s��](��f�6���&W��:`P��F�p%��>}��聒'�-��U�-Z�3!>.���&���#����(��*}Qע,V����܌v]��"[O�oIo����c��hF�c���/���^v��h���V��/���txJHz��4�h�?/Uu�y�'��@XFB��j滨w�Xx�H�Bʧ�w��x�f�\,�x'�Yqֱ���Z�DX�NB�VS�@�Y>P
?+Xư������G�G+���Y�Pǣ5b+�#��5c�M*+�w��a���n�����"eڳԟ-0�lM���8��_[J�S�t$�C���YVjˡ�����'1�H� ��7���%��|;!z�����|��;Mxz�"0D� v�,��#��t��y�$������|��D:�?�[{b�h���d�VOMs�!�p�Zx,a5JG4��߶�˿j�[=���:�P{~�@M�����r̾e��}��9�L5.����޴�KP`C.�j�5��z�B|K�T!u�r�{�b��k�ʤ>�z'��O*�%kL�T-�D�g�ʖm�x�[��W�~�IU�exj9��V�,
j2�����aH�f~!~�g�,��z�Nrv�TXI����e�����? ��䧮g�B�h����e��a�ʵ��,z�s<Й�(([���w����R�V����]�R?5���DlIU}ԩy�F���D�q\���i�u�	��6n�|#�����e�,�6�+��w��̤mM|n.U�5(5Q�-6���t��W�j��M�s%�D�����ڱ[�4(�y��m^+5�W�-�T)U��hJ���Ԋ|I�kԤjgk�].�K_�챣�S6zpu�|z�&}Nmm�쵡�]�~2�6����c(�Y-3��k�Z��ϒ�z�m�Vl2b�:�	E/x��"�?poo�×t}?��}�1e���h$�[�T ��t}�:Ֆ}���+Or4$��/����S[��W6B��\�'m��7�>h���eQc���[�Ŗ��v5��h�)�$^U�^Ƚ1i�X��w9�
��g����U;֋�y{	��!���&�U��Ak�|Ikz�u�� �
P��aEҊ"�A�(���F�{��(�`]#�M�ϋa��3B{ӮO�a�p���E^_�{ c�B�k?|]���M��fA������Z���
\�������Wj^�ǳ��}j'ϫ+����T���hKv�<#9��6��	tF�3G�@e�mVS�u|�&���-�L3�����0�+6������,65h��,��&�=��YS}����\�%�d�"��������[G����6	���Τ���f��/�=����I�����:��0̿4���W�B�{c4���b�tH�G >¬}U���������$G�Y{n%֮��fd���k?�8ܭl�IK��+��I�*~��a<ޥa��Z"&�d?�l�Ѧ1�9Kh}q�e��Y5�VA7��L��B�ߕm�f����v��@���zB�F�C���%f�ܓ������p�J!�p4���]��	MIk��p�����*p���j̛+�p�,�\_ �ޢ��:��9���tF8}i�{dXk-�Y?u?h���=x�����5���ym�����Q1���yɪM�g#I��Z��'%"h��H�I�j�kDQ��J����рIO�aK�Ȓs���b�{���0+YH��d[0I��f�R j�J�0:��cW���7a�~8�ӄ��b(N���	�'M��j�C~50���?���?�B�!����gp��ze+$���L�X�징��D�?���GՎߠ��_?ծ���s�ۓ-���@,��P��0���t�U;�o�6M�~|��N�<��o��t���:;>�[��/D�ߓ�����&Ǻ�6C��׾LZ#S���Fx�s|i^_&��&���&��m�_��}h�_�����G�Pz*���,?aҬ6!�k��u[3�-+d�eICC�����Ӷ��6�X��e:���÷��^�T��������ȫZ?�'��Z�O���Ss��(j�����V���N��8Z�t�)rx���\�̧�o��6�Cͬ&��jƍ.q�|�X�\ʈ�n�XY�S��E�
����X)E��ǥ�q �A��_ο$�g���Y�!��-f���O�q�S|^�fn:���Qeؒ�}�"�x]U���V\���A�Ke?ؤ5��fy
Axl��	�9�~�<�՞�,�����Ƴ�+��SH��?倖�%�����~��%x?������TIxsm�T%x?=�}��Mݿ�E30i5*�]�6�i�'MU�b>�l��5W䍸�|��H|�F�m������}�k���a�yZ���|������W8���^VMBֶvi���}��Ϡ*?U���	=�?�QAZ��Z���2G��;�%���5�~�&�Y����1�_n��	,s8�+�Y{��S�/�s�<9�Q���.�:cו�%���y9RTӺ�����t[��V����,��g�7���Վ�|x���<�ԉ� ��^���kM�L����VM�zu����K�Z������Z�]h�Z�m��j��%�}[��z��%1��=\$K�ۥ�.^��Q~˖A��K��"̗@I���'��'��3�!�m��k�;���>�&�N��τK;ן{^ڟ����:Ǔ�m��d�Gqu=m�?��㋼?&VK�ԙ��<�X���zL� hŭ{J/�e�q�:�������tqgD�b���M��־�g!V�a���7�D���G�y���B�Ƨ��!	,h*��_���_������'��V�tE�j�X�˜��l��v�Y���'筸�A�t�x�/ǳ�����N=�#��a�/��8������%�X��=¤���3���w⼇�?N	�)���ak����OMwu	$~e%��wP��n�7�# V}�Lݝn��q���]D��7ь0�=���X��?��_���9��Ν��=�?��WėG8M���7Cڷ�z6���u�<	����o��Fz�J�U�ӫ2R�i/Q�5��ӱ|q�~�H*��AlmM/qaz�kǻd��}�z;t����m}��z�{��:^v���mm��q`+<�y�����p��B�:����(Lk���5rm.�6�E�o�U��ݰ��z��М5Z�:U���<9N�`���"�J��G��b�%}�^S���(�3�<b�~�fP�?%R�{��;>Do��w����L�6}�H�.JUew���&��uz�����&x4�Y��ZqJs�W�^#ccAk�^;/K�^�ձLsD���cY�>]C��Q�Q���t#�>��}�I,�����1Z9-V��$��$'��qeT�����j��c޻�!G���x_�	y�M'6j����9����QR�{Bv�d������{��?_�Y����Yu>�C���������Zx�%$sHY�	Ĕ犔�-)�r����{n�FvB8���Yx�Q��ʐg2���,�Y���UNQ�Ւ���P+B&W��("#^��^�<,�]Jc��򧿡����\�������2�]�9բ���7��'\>�$"�£Q	�Od�Hh ��#R^�Ǯ*+I���ڬ<h��������J|�d�e�U<��_xK���kJ,���?��V�&�&)�۰ğ�%.�|����NR(��"�|.4S+R��5��45X:��Z�RS��ﳔ��'M���1����W.��	�8�"�&�y�@�_O�MU�$W�,�*�o௞�=o��y��	b4��_��i�<O��^���I�FX�����~8:����cC�����*��]3�l?�����V+�fm�e;�E�<�m���ދ���lu��ֽ������}00�ae} �P����
B����Ȗi��T�s8s2V&��2]��������m��Q���S���2tv�a勷tjb��a���_�L��g3�����
��~��q�+G�G��#ܰ����J�o��|X9�Fv����ఒ�V��G��2Bm�~X�����b���y�"�}�ð�>C;��"~�W��F�+�����G�a�����E�CV�����֋��
�MX���9�a������_�%NV��K��88X�ᆕGΉ0�4	R�1�XE��u�ZC���Fq�@x�VN�a��������<���F��@��_�����V<��ڏ�8]��j�ڕ[�����:�|:���?Helmչ��Z�?Ee�/�S/��-�a��`��cGV����h��U��h|_[@�P��Yu.�p��ڂT����Y�M�7�(�M]��ڱ��y�!d�7$�d�Z;/4��O�?M�e�hOJ��ȫ�+'��}�t�>
�wVPzg���4ҋ� ��'�,'z�9۠>9;D?��'��L��3?��;?�77&�ԘW����4��1�Q��-)"~�-0�Q�Ϛ�Xu�Pջf嵁�g�y�m~�[���7x%���*�T�*	�gm�{�Cz�H?������~�	J =FM�=����[d��K�k嚀r}���p�%��TEB~�~�\SBD�y���"��臨����{�R����lO�Ԟ�hO�l?�"�G��̠P��!��"�7v�G��A�I�R���m�|�G�P��Ϊ�I(wc=��*�E?��%)7��Md���@�q���z��-���Nr �l��s�'B%��<���h<5(�K���I�D@~�J"ȽJ}�>�'f1�RR�òS���΅�u.\�r-�<���z�����������W������uv����`�Ѡ�Aa�l��(�i8u���&��7�|�p�-�HZ������WշX���C�S���������O��Y���W����?뉯�3��}V����I�~���1S�cS`O�}�QQ/��Y���_2m=����;��7�c��Φxi���z��nϪq�m�F�{�z�|p�\r�*v�eo��-�c����	���H�����ð�f:�oz�Ħ����/��+8a�*=��S#�/�0��6S�-��(�{��@ͼ�B?^�����|�J���3��2M�I�:�IFO����$�!�	9:���o�{'M<�2��&١F��B��Z�h�XM|f3���W�x�RpZ��3M��@�ߙ��t�|gG�;��A{g�F	Mo����[�|::�QѦ�Y�3�7U�ҡ��(*=�<[h��p��������*����)����?�.��V��q�~�Y�P��M�΅���L�������1����{����؟;
�O�(%�3Zx� ��A S�]�Vy�Z�i�?2m�&��m���3�J~z�of����%c����iT�'�O������C;?a�bc����ܿkz#d�.(o��@,�,y�V�?��>�������v���骽�8�U��z F�y-Y��Z�xvJ<y�U�hMBVu��,pgO�G9�3�[�E}vi��'��D��6z���o�k�|��7���'j�"o��/��y\�$ަj�����z1��$��F~�B=R<�(<����}�����#������a��|M�'���B��1�t�Q�d���砬�����=f!5(o��&�$��i�^^���;м���P��y�	��`��$���$�y� H�%3^�����>Y�֬�?@R1q�n�Θ��6l�sy�;+��c~y�L�$NO�v����~�SR�Q�R�K4��\�D{�^��M��4�X`�(Iy@6�&��~-x���+��Z��k-��Us�\}�����q�k�K���)j��34���n�ɻ�Þ����лM΃��Nw^�_�h�[��	*��>�ޏ�
�O��O�A���.���?���2�����烁���v�j.z<�����!OU��N����𳵎o����4(�7�V�q�N����U5��y_�N�t�����$�V%�	��Z�����
7S��%�`LM��۠�e�EzTt|���1���Й���O��kӦs�rud��	��(��Y��&�W��c��m�wf�� #	)��7_%��U���%���8�T>�vr�����q�-����3m����g�q��� f�΢��0䟮��m�K����j���������F3d��g�.��U�9(���a���G|�Cm�������n'��K�pR��ڂ�w=����0����O������Z���9/{[���L�*�V.6��3�R�N2���<��h"�7�k�_�����H�>��~�GX�D��w}����տ�(��>��8��ק����Z%ah�0����[P�p���oȭ�M>�Wn����Kէ�T&���������Ϙ@��:Sk�q����s�h�g�����?�*u��41��0O��%Zu�}���/6�����W��a���ۿX���=��������'���ο�s|� G����iʬ���d'���m�~����Z��;Ձ��]�H���?I����Q�����=���C��v�)ܣ�?I{5�g�����9�������φQ�O�i��G{����W�֞�A�9*B�騽F���S�ߡ�!ۣ|wRm��c��l/�"�'>\�Ѐ���V~�)Ln8W��+r�{(�}�z�j���"Gm	��B<#Q��ȯ=&H���q2Uծ�lɤ�=�~�R�x���^�)Bt�𡨍��d�$}%�ɻ����լ�����﷪���ϓ�WN¢��yMx������k����Hjo�y��CPtkU)��S#O���
�0�;�k೏Rk� 5q�� 7�5U!�4�i]��5�	��z�n�\��gF0f:>��2��/���. +�Σ�7{&���&-���E���o%!������y��nF~�	�M�M���Wn�X�C��;�޶��E��T�c��sR���<����+OrVm�`.���6���M���i����v.t�=�W������g�}^�%�U!b����g��4�5K�NM�����T�[�5�U{�pI��d�0y�Q��}�nU�A:JT��˯��hx�Y($W]�Ӝy�#F�J�ew���PG�G5V����7�p?D���^É��@�������w�]Us�{���_j�˭�����*So��,A��X}��Hv��}��n���~� 3�qS?q���Ɇ��d��}QǅƱ,p�Ͻ��29�'e�R��bL��4�V�	§�A�Q�c b �Ǿj�K�����,������0F�ۏח�cG��,�Tb���ɲ�x���{�%F�bY����!%η�)&�IP�c	VÇ����j�m�<!��$�.��u&ߙ��������G���2���aL�pv7٩`��zgr@3R1��+X�6��&��)Y�C���p����U�Xt\�	�X�c��,�j�2С鷌Q�:�cCY/�z��W%�b���Ԛ�zG�Z�;�XK��ZjR�gӐ�&��޻��B�IÂ�B��a!�Jaa��	\��3�J	�RY���=}4���U��:@�ݽ��K���Re�����;#�X"Pz�N�3^�8�-��6qZl�|�����<�����+_����Q������r�X�~�@������_)[+4�'&kG���!�F=P�NkV�3�ߌ���E~��O�0��|?��cOO;_��~�g��S`���&�~WG�&�\#��G�4���7���}/'{��{9o߆�O�^�r���rn�;5��y�6̢^���vZ�>�9���Ŀ\E4q� x����'�����4r�i(-���)�{9�z�!�z���o��7|�e�&Zˊ�\� ���\�����-S7�~���-���~˴�L>)r�m��F*�hN|G���~�u�W�}��3$�s��7T�F�%�V�:���~�by�'��-lˡ� y�j�w߂���o�f�:��}�e�-��e� ��.�~K��r���%�i�R�_>��{`:�y0��=���o�/$�H�[�I֎`��5fðέ���ԯk����6w��{+���3;�It?���93�S�[y;����{�W���!�7G�ITO�͑�S�H�����OY���[�ۿ����|:@����S��o��*^[�ufY���ռ�$�͑��~���l���6�t��OI�t�#���y��mڻ�[���)��}���mtK'm��>������I�<&@�����q!4G՟O�����_�wH�3�e��e������~Lw���&�
�:W��Om�<���B��}�6�.�6�V�qL̚o��M��>*4���omo7�O:!�Q��(�!���ϳ�ӻ����%�;=���!�h[��H��������5��q�p���Y�׬�-�9	�ֽ�7n,c3�s_�:Q�I��W�\��(O*�$?��G&<qv�C����yV�:�:�Ș���Y{_�s�Syx��I�����:�>
��E�P�ԙ�J��>�kY=Ps��#)�u�N�'Ly�ީb^^�X�Up>�*U���8c8N{�}�l�Ga�����D�wX���h�M�#�q�A"��hޣ�Ĺn�k5}�RΟ��6����w<S�����tyw�����f|�$��+�j�+�������o��kd��z��=I+��"�̓Yf�6�_���iS�������8�����$�|}o�*��&<n����G��['?�z�l=i�}��.�l��^F(4i�E�9G��a�{��,����K+����/���DȻ��G��T�NI���E]Z&`��y�\���沅o!%r2�K�7Q�K?�K��!�{�a.�۟�}Txv/ýnʥ���2YR6�G��Tyo�oh�R������Cq�o��[�k�8�@OQ���a������_j�7yo��'�8��G��+�Ϋ�L�H��ߑ�������μ�v<�Og��Y������E��M���;���K��ٺH��_?���������C���t��;���c�+>;oJ����Gkƒ��X�y�V�M�i,�=�XrS���ۑ�ַGu]j���Ch�DKhF�x�u?J@��{5�^���φ��/!�Mk���8���!1�U�)�;$��j�o���B�<��n����T�	,p ��|�Q�\d��0o��0��&7�ƞsTXQ�_�����7��t`#^:��|��R��K���R�ه����t�v�#�����S�~�gß�V�u]��ա����GL�og�G��q�Yx�+P4?N�6Ƀ���8��["��a�Dlg��4���m���A��c�3:��@ݬ!0�;(��g��T+?�g���&��E���{��M��n��3�Ij��m^�t{���\���'n�%�o���pf��h����4�9�>�����b�̠��}J�%=�#������r��:���S�ɭ"Pl��B
�v�
'>���w�" ����p�w��� ��(�U]�o��}J�j�K������8�A���^�+����G16(I�ٲ�sƆ-|�W�0�M��pbю����F��������{���Rv�K��}DqvwL���z>1F+Q��|{���d`�Yl��ּjN�h�O���~R'��-zy����q� �<]M�hT��`!�?=N?(��1�ɰ�8�b*��0��@��~�W�w�O؋�o�����x݇��xm��/x��������x�����k"^{�Պ׾x��xM��`���1x���8���x�ד�:
���Վ�T���u,^��u"^O��x����f�u^��z^g�u6^�x��׋����z^�Z�W^K�Z��J�.��
�^�׫����5x]��k��������7��f�>��-x}����1�6��5����xm��[x}������#�~�W�������چ�_��^
���o��w���R���`��XF��
۬X?R��J�)�QYN�V&�]��aMJ*�c�A.�����T���g�Zma�+�7[�;J����Ng����+�¸��'�ϯ
ۦó�W�=���q�(l�r�{
��r	�7#����Ff��	ݳ�8E9qH�W-��[,X��,g3vmL�31�&f,c�c���쌁	� ָy�aP�qoY�ݖ�`���x��$�N�bS&���^?*�&���l�3�\:|t�t���s��e���kq�2��|�e����=dy~���(�=��s,��|���9��uK|6����>�&ĭ�ξJH�cw�?A|+gC��gz��{̌P�s������-�1�kul�?b���Do�+浽[�=�[�xV�y=���;�.!��;;�ym��b�` �lcӺ�Z�%��;��F�TI|��n�>�$���M�솸��z�[�}��n��x�y���+!��;[�=���4��H�q��d��X���!�4��BV�qM�9:H��:�.c�IiN�5+l����J��
�U
)�1�����w���ĕ���)��S������[ۏ:j���ެ�����
{VԐI�Ձy�d��XZܓ
;��
[���NYA:�,�Ί۪��!�+l�҇+�&eeP�w1;�-���q�Zg}fk�>���5�wv�����n���;,g<��@s���S���&>�^�� ~?�-��n�.^�y+>�֐P���=����3ݛS��_�uc.ܩ����J���o���[h=&�ɌM���M�����&��cg�Զ�\v���36=��f��?.�v�8���.g��2����e%W��q[-�a�Ya�GGu�Y�(�>�5�{�%�-�[�0�,��\���e���u<���5���"��^w��JoW�֥Y<c�/��j��ێ󜮩ӝY�9����<XK�.��O��x��ee�m�����K�������KJleE����l�ew^9�ۘm��rw�(ۢ�rf�(�4Ӌ�]�e�Z�y���r��gZAqn!DC�LwhJ�Ӥ$}ʂE�2CB��t�畹K�F/-(,,),�t��v�.��.�����HstYi��uZ����u:fgg�t�2��i��)����,�pa�bw�=m�!��^��8�x��s�h�w�BBW��M�/(�W���LBٜ3�˧�����O�Hq
@0#F�J�my2Ķ0��Н�<���)�8�f��<�ғ[�[T�9> ���., wi�K��8�2y ��"��MJu��LhQ��ʟ�I�F ����s�˲�PT�܃���"w��|ܥ��.*-���PPwH��S��� �T��T �m+?���7(�9�gg���ʟȈ�PC������`� ��a�i�� x�M�20��t&gcWn����Pn��=
���|��N�e�$��3�@^��G�Z\�;Y�al>���@\;�w��=�4�VX���t�;���,�s�?��}�z��}����,��m=�����T��f�g�Aă�L�#��4��qp�1v3����.�뗅?��p���/�ue���t@�Q��dpmK�|��;�Oo���`���v�\���/�9�\_/�]r�f�Ep�^�v����D����q৚�Bp[ׁ���k����i��m��� |�\ۭ _p�]�sc�����ؚ'!�;!��.(+�9�@�O�������c���@^����DV�>���b'Ca��	�HFS��˔�X�ݘ��<�3Ŗ ����'S꓀~���}����gJ�84a���C��1P�c��<��ڡڠ�8���'1�a�Ŕ:hkͣ�n
�w�;�t���x�(��1�6x��c͂�뭺��B��hG�s���-)�P�lH7O�� ���σ�烝��Κ���� �����s��!�?ۥ�R���:���9�s��BH��w1���s��2�0�˜"�0_�/��(;���
����l��`�2��}І�g[	e���
x�6�\\�5 �� �5,��zr-�ƐKn��ȍ'7����� �'����"�7�I�Z��Cn_r�"����@�@r��D�`r��;�ܣ�=��cɵ�;����=����@��D�rG�{2���;��S�=������M!7��1䦑�N�XrǑ;��	�N$w���{�g�{��N&w
�S��$�A�4r�&7����C�rg�;����K���?�;��lr�;����=����^@��^D���^B����!7���摛O��܅�."w1��^F�r�-"���t��EM�DM�DM�DM�DM�DM�DM�DM�DM�DM�DM�DM�DM�DM�DM�DM�DM�DM�DM�DM�DM�DM�DM�DM�DM�DM�DM�DM�DM�DMԐ��_G�C�����������������������������������������������������������������������������������������������66��;�#,�y�U4a��&��k�f��������� me�)`s�^�^��^�
l?�)���{�F�߀M�@���ցm��n1L��=�2���>�=�~���2%l>�u`w���8����c`_����Ɣ�`�����e�,�xv`
�n	�@c��ޝYց�	���z0Kqv�l���@�[�~֞�\��,�z1K+�����;�Y���le���܇Y� ;�/�������£؁i���5�ف�����@f�2�(kIf�[�&b��A��p������`v` �L�s��f��`}`� �0�Y����bV��kS^���6v(���D�c�2�:���s]y���R��R�;�E���%y���c�������UV^ZP�H�,r�K_��9]S�;�s\S��w�x��xʌ���:�����zc2��`k���`Eh��rW��xQ9��t�.��O+(�-t���<�@���<�y�sˉnf�"w�1-����6���$[�ԧ%Om�Y�1�GP�`���F5y=�3 ��
��'H,�9�wI��8�(l�*�VyzrKs��4��҂Jw��� �$��Rm��e�����Ҁl��_�nv�L�s�ɳ@����+�z��ÄT�KTQ�p|��̙<;ӵ`y���~{�{��5�xiAq�k���B��u�촼ROy�Ct��������P�/WIE�cvv��+%%uAnYA�1=ovv
x�-�N]^�[P^6=�����斗�
�Øø.%<����qU��
J����J����c\Z
c�B���2�kan���1gv�ݕZ���h|AI��r��&I��]��RX�8@�45�ᜑ���J� �2SIR�r�]����˱��hS;����E71%�}94�rW�r��QP!�w��҄p8�0E���-++XT��"E��kDc+PA�H�oHS1k)Ɔ�bw�r�?WA��q�)c�v���3�R�B`ё�����0
鈈�yx��Z�q䴠QΙ���:bB��{XDr�C�#	� %wnQ��?�z'�/,�([�g�S	ǖ���K����0�e֩��e���I�k�crWc�VƘqe�B7A%�b<*�-�1'�᩠�8��S]��8P���C�o\>�wJK�	�	r�s��s�!�_���"!{��0x�(4LfzΝk�*ҋ#�N˃qǡ�H�#P�m�����VB�
L�x�f��3��μ�v������އLiq8J�Ax 1'�arLlsaZ#��t�U�._\Z�TW�@�t\�8.a���ݥE0].wc�Ӎ���k> c�yfi�s�H1�0芩��*a~^.�a"��R�	���[��"��a����^��,p/*��p����z��ihJ� ��-��miY	,
ʗ�*�·�<��y������Pﳨ"�����.�)0�e������"wQ^�G�b5nQ��k��4&�>L]�ZbU'�ށV챬��,�Ŝs1�8G\�V�d����0b0�h��^�&1K����`�cY�"Z=\�o%�8.bY�M�ߏ�����`1SٜL��U �C"^���=��� �1�-'L��|��`�+�tI9��=���h`�!��#��>� ��*N��Uzp�#2�PA�?�\�5?$�}�rڂ�|���7-"���hc��Q*�v�!�&���d�.��K*���{D��kcEU���EQ>���X��`���_b2�M����e��ܲ�Sa,r/+g�+���*z(5���/c����>,�6�{��tT�H�`�ĉ\�Ɓt�
�`��c����o�s��q��^�oGB/�	5��^GBoB\_��Kq��+qs��@��8�Ɩ8��w��/��w�Ҹ�����n,6%��R�:B5�IM|;�v)��?v*[�-��w�aSXk��d�����ޭ���� �^Di�P���Qd�#�������~*�l�B\�\�)�d��o�Z��K
{�E��3�{����vǦ:+��2s�c��L-�,v��Uy0�6����i�'��=�� �>����$��b;��\켌��0�<+p�fȕEl{ڄ-`��8k�C�މUy� }�}a]w,�-ݱ�w �֍�^6�>���m]��2��z`��=�������dufu�ں��!�M�܍��@_[�)��Zە0�}�#��!jkSO��+V��H�%�g�޳�#�)��	-�;=�)cPw�.�P"�εZ卞�Hڭ�kx�Ic��5-�(Ǔ�+�g�Ph���,����?w	㵽B�����u�B��p�bl2�
h��z!�{W��{c��D��{zC���y�Nw�u�B�_��y!P������Y\J��S���3!x��F���9�=�;���[4����](��Df�R1/��'�p�5)qpK
<�Nb1Bg�-=��d���(/(LaO�����5���>����Ni=X%���]Vw�!'���,i���#ު~�a2�b�u{�
2����|��/��4��O�o���\�m�]ӷ�v�x_f�*��n郛|웾��/��Ő�N'�uTp���G�� b�.�mP]�ߎ���z����E��?_�J���9cq{�����l?*�GG�a��Kc/��Yb <��?P�<9�BW��W�_v[ ^�J31��;Ef��"��efdf�@���?��@�狌�#��� ����D]e���� L�z�������>���D�^;t���e�A�=�����.���1G�9b�A7�;ؓ�D"z�&i���DWom׺���Q�b*Z��e�!YVC2hOXH���Y`Fuĵ��K�k���٭T���ʸ'*�n�ԋ*٫*����B�WaȪ����T6�m�T��L�>HT�m�A���Ҙך�|G���$�i�x�2`�x���q0;��f����tE���}98x��DF��/ Q��Oh�ne%����<95��P���)�a�Aꜷ����DG,b�M�SR�4>���t|r>�W�+�ݥ�������$J|�P^�N�+Y�P�ؙ"�i�~~�������=C!�{Qx��҄�����BsLk8z� ��I%{�y_�p���Ѣ�)醻L&�0�J��<.��B%��Ǐ]6_���CwT��i�Xlr=}��(��oBl��y(!�cRٞc������Mm-��zlL��J(��a:����� j�Ka\�.c��uk�W�z��h]yho7��4w����_͠?o����f�F���f�X��-�C�-6��F�m�jqm�Y���#��}b*b����a�[r�c�G�Yz밎�?����}��l%�g�A�꫆�����v�qXg�<�?����&$^�J\�)x�p�.�=Å��>��w�C�Y�l�[�`���ׇ�����.���|��k���{��i����>�^ɱ9s���l6��	IlVpĿ�f�Y!�k�9�1v[}���I�N�SD�DV��V�@Z� ��Hk� Qk��^��lN���@��3#hA`�� ���=�X�B$��i��l�i��حP�:�͞�뀶-�
�96Ȯ^�"�H��g�@�!>��l��f؝N�ϖQ"�^%#G�<
 �j�ʀL�
X�@�2<u=�vU�$T����f�JAN�8́�2�`�� �OA"�<9�	�[�	ȧx|��0	'0v��eu��������p�턛�K��D��'I���w����?M��'Qz�c	����}��{�>g�'�(���F}���[	@�Ox��gС�{�p
�Gx�f��FI�R$~���p��T£;	�!�)a/a�iT�!�L����R%^G�K�[�!y۩>W����u,�O!�	?E�9^bk*�'<�p=�2��	o%l'|�p���=n ��V�=҈�D�G� |�:��'�N�'�&l�$�N��v�p,�#�����6���%��p�I�(>�\�~�ՄmgH���q�=����L�O�I�W�$6��o�ċ��M�C��p=���	O�H�&K|a'��	�>a���*­��WçH|��Nx+a6U�^g��	_E؞)�QgR{#\@�9$�M�F���Hބ����0�&������? �Cx�d��[	��%�G�N�z
��	��9��aa�2��,ʏp�����$l�.q�L*�7.!�L�������u�|	7v>iɛp6�f��ΐ���)=�O	����G8�������	gN���$�fI�&��}�!~	�n �
�V�13��l�'��"\O�[�̈́O�I�ϕ�E�N��N�o��1��#<�p+�z�6��٧�s�M�vn%����?F8���\JO8����K�sΗx?a/�NJOx�f�"�'������W�����'�'�6ag���s��k���p3��D��
�v��[�~��g��ֹD��%�}�� �I|�<�O8�p�b�O�K���H�����E���I���g��p��)?�[	?M�]&���B�9�"�%���m��.��v� ��p��tɛ�R��#�LxaVH��!|�v������KI|/�z�~­���}:G���N�K�G�O85��U"���s�B��pj.�#|/a�G�o	{g/ ~	�&l�\��{���	_O����p3ὄ���S}�J\D8���=�OvS{'<���L�k��#�Ax�B�G��p��	7���[.q.aV!�ㄭ�9a;��Ŕ��Մ[	7�UJ�1a/�S
H��7~�0[J�%l#|�e�?�y*^&�C�m˩�KH^�W������*�B≅���	�	3��c�r��}	�'<�����"�	_H8�D���^��	o �E�A��	?��Cx7�;B�i��~�p\���N&�9�S�#|�؇%�&܏�"��	_A8���3	�C��On ��p�#�����^�^��o&ܷD��	�@�i��	�Lx��K	���p£o&�L�1�#� <��{��E�J�	�L����C�D�O�H�e³	�Cx��	W�Gx��?I|�~��$<��N��	@8��7�/&l���p?��	�H�Q��	�H�»	_L�#�%��?&�5��o$|%�-�o&���	�A�in"��p��Rj/��n#<�p��O%<����G^B�t�W�Ix�	?@����~�p=�	7���?aVF�A£'>����'<�p!a�+	���p��	o"�4�G�Lx�w�I�s��$���τc���W9�o��'�F8��ل3	_Hx>�"	{	/#���Z��D�9»	�&��O�#�=��'%����N&<��)���E8�p6Ṅ�'|�r�7^C�~����N�̈́�N���^�~��*�OIܷ��'|ᙄ�����/%|%��	�'����o%�(�G�H�%»	�M�#�_�K�g��i��R}>��p©��v^Lx>a/�%��_E������O�G�Y�̈́_'�J��~�?f�H�Lb+�!�m�GN#<�p&��	�%���b�W^Fxᵄ"�������F�M�­��S#<�p�%>�p?�g�"�$<�pa�J�^�Մ��A����� �#�.�f�{�>@�O��
��g%>�p?�'<�p�\�Y�+�'\Mx1�;	/#�ᵄ_!����������Jl#l%|&a�u_@8�n�����7n����'�a{�ı��~
?��u��W��,1'\O��[�_
�p�F��R�M�B�N��1���K	7��	�	ϊ�8��{X�D������	�)~�8�$a�L��[$^@�J�K�~�įf�J�W�G��(���#�[�ل}^D��.��	�)|a/�ߩ�'�5a;��O�މ�뉿)�s_J�N�;�"�l��.�^�/f�C�>��J�I89��)~:��s��$.%��[�~'�|��o�#�OM�N�i݉���N���On��xa/��A=�~�^��)��^��Y���Oj8a�~�����K�z�ģz���>��wJ|av��Wθ]�O7>*�0�I�I�t­�稘җ�n&�	{(�G/�F�Nx�N�O#�A��̈́K��"��x/a���/�]B��M�i�����ӟ8^���i�p/k>^��&�V�$�G��&�C�U�7�}�H�V����A�C��$~�p݉��C��<�Ʉ3FH<�����-�mD�_�=?�/�G�&\
��p���%vn%~�v���IM�J�7�(��$�~ѻZ�<�V�+	g���f�9��R�)~l?��?���J��	{��$l%�G���J��[	琾�F��V��I�K�ɐ�T~
�BؿI��Nµ�}��	��P����Q��$�A��|p����j8�W{�=�S���8��%<�����e��Ծ�(������p+��,1����	[���y���WnM��>��t?�����I�0Y�;i�_��t�����~�&����f��t���h���!�Y��ـ2�?�+��a���u�7�|�/0��|�?d������3��G��1�b�S8ۀ��r�ʀ7���h���s�5�Sx�_b�Kx���}�Հ[��v��8F�'IlQ�l.4�k�n��|�M���+�{�g���'��3�:~р�3`��z<؀�\`�U|�?j��p�s�p�p�<���b��o�|��7�{������k����m���i��p��y�;��i`��v:�s�� ;�,�����	�`��;�<��Y�:{>��^�"����`]`s��] 6l>X7؅`�]� �e`��-[�l	X�����-+ާ7l9�
��`��v<�	`'���t�g�]�
�W�]	�*�W�ϭ�'T����U`�{����N��T��`���[V<�/��G�o���`7���`7��Ê�p�+K�l=X��xC<���c�,��Y�o��k�^��փ^�������O[�ua))�g���8�9���s"�V�J�H65"�԰d3��>Unv$f�K���ǣ��]�����l�Ήc^���-��č��5�#l�H�������S�|��yE��#�."�H����ZU<�P�v���2�.�PC���#�u#a(i^&Fh�1�W���|�J�H�s�\H��#1���B������Z��Y�P����� <����G&���H9G,sh	׳�&���e�&/�1�0{�>J���]EQ��T�熊'��H߮����I��U�5)���I����6��(��߇�}z3Ŋ�5E�ᆢ`���#~N'�蠘�-�|C�R���ة��b���Q�CZ!���*���X��|��kx�/�1���'#�	�Bǐϸ�x/���a�%(HB�@[�c��뵑����0C_ X�Z���1&��	�d򪟐Hi�^�3���1�t��:��1*HV�u��sL��r��:��E3�젿i���N�L5��wA=��+sR�o42�ЉW��
}_Mh�.m�Z�皗5��hCL��6���AcІ�1�i�w�y�֡	d<#tO��� m4��:Ů�R�h_�.U��MLa�u�U���4q����,��UL��^Ф��uL��ra�{ݒ�d*l�b�W5i�:���`��ب{�Rhx��K�:-BY��^�Թh�ԏ���OWt��+�����U�л��_�~�+�ծ��v���*����ז�_[
$:��D?����Gq#�������ªU�[~VoN��Yi臩)���Ŏ�>=�B��V]��Ժ�C������*/q��痺�ʂҙ�`a���a.4!)���d��<���d�\�%ŋ���X����]�N� 3([\RڡdƉEU�GԐ;&���q?������G�_������<L���!��`}_t�9����v� �0�2�D�R�~�H�<K���d��\fjj>~'�k�H�-߽0��P�s9�'��s續[D��\� r��O���aq'�}��k�i�����z؂��[����c���s�Y�9�r:*a� ,d�K����09*X8]���߉�����*,ӷٹ��g��υv�=֥_�iiu�+�Q����'���d�=�57E=� �v_~�y/0#��#u��J����г�DV�\�L:�d�̻��e^v�K+�4��w�nd��)Д��u	
�yb\+s_^�.�saP�4ڱ�q(�Ej^���#�c��)�(�;dT�N�\T,t���/�H�۱�����_+�bt��n�3#c��v�`�ӲS]��􅅹���L�&H27L�i
�M�� c��ϝo^r1{�h,׬J.3/�҂���a*;=��$��vTʠkzΌ��.]�u��Y�PXYtA!R��|�Ek��.��E^r��K��}en�v��w��$�P5I��3�42�$��1R������tJm���IJ`CP/3��Y��
�)�@9��"����{�����Bw?:9�ɇ�699m�|�W&��́;{�A����?�&aOjLQ��&|��l1�1l�t>���Ր�hP.W!��EEj;�']ե�z�)-O3�ΙQd�|�5���ӧNY������$���D��H!�`l�!/w��"�:��9c�\��/�t�v�P���k7B���X,la]
>o �"W�H��>�%K�oޚ��84��_'���lD�l;��M���W�6���������T�K�'riopu�4�.����UV��*u���������e��SD�C�)rk;�!�W����n%�v���p*�HE*�8,t�i�vv�Y�i[�N��r=]Za�5�C���#_ݥ�k2������M�NW��Nǣ��HX�.*�(r�B�
�D�c@M��)�Ka��<��eL��EHف�
w��l�'�|G'�N\$O�i�d�� A �q��$aBV۔�`WP�*����84 5�t�7oz�)�%���E�~�� 41ge�GW���b���<G�]�(c��f-!&�N��]����-�K�/+T�j@HPn��`I�+7/���=Bn �
�C��������m[���?N��Q$�7�U��D/����6�7Z�m�J�*JN=���� )Yv�V�Il��b���], 9�|�Ǎ)�[k��P3M[4�����i��?a�֠9��#p+ҷ�5�t���I�ῡN1��gS�1�#�!b(G
Tc0m�c|���[��C(5(9�^�/�`n�L��b�q�N),��݀�c�ö�I
�v�(M��y_&$�d���v�����јH��c���u&�V���d�^�ã
4��ن�h�W�]�36B��������A��s���4�ſ��|����/	2���Ǳ��G��u��w	k��"<>N&�W�	��!A♗Nb�2�*�'AQ1I�A&y (=sU\�7�#x����/�ަs�Y�c�����qU�0ɓ�B�d�p0���ϩ�:�[}�jV'�1RC����IjwQm$E� D�i�+�V	�?�gj_�zN�zvΤ3���5q�B5c����1p죙`d����p��l��s���CcB�4�c0���}����8�^��C�pr��;� ��yW�Knrޥ
�ƒ+ue�g�at��R"�%[������J�3��В��m�����F���ۋ|8�బ�������d�:9���^k*u�2�Zi+du�s�Eڄ}�̻e�7���"쬋p�$��1��ЍPB^�:��3��[���j!#*���@�id'�&J���yE����*����ĐFd�wH��>	Y�sg˲�`�nRb/ʺ�lW'N)�G#o���7ޤ�������ei�d=�D��H��7NN�����7�5�ڠp�A��c������J�</��~$�pC=�Ö'WBʂt�ՠI��F
�@��Qw�r��^�[�T������~���$�ܒ�ȫ
�
e��U�����|{�5��ՊBq<���Z�0>�A�߈�X=�౺�9��;�緫W͔��1$k�>�#�ڣ�?�۽{0{]:bC�~M�T��e�X�k��΀g	�����2�:_�5&=i�vһ��%s^����cn��z0M=EZkzf�4��X��h�fE���&<��ZN���j�>ʚ-�:*kɈ�%#G=�Eɕói�E׍�c���t��������z�88� E�ь7/"���i?-��VA(��D]0�ڜ�:c��ƖS`(E�[?���]����y��Y }b �ko4�x���	�12DFn�|z�M�i����a�p
C��O�dX�3���{�9J[I����D��K�%R��b�k�*ܨ�aY�v��*�?�]D��m�ւ=U���e)��c�J}�_^z3�y�$�rl�፫mI�F��h��V�T��4!s�vL��w�e��fǔ��5|������)��T�9&]�`�;<F)b�@m��=B���t�H
y2Q�ؓ�Ժe:�'q|�YJ��V��|"��E43���ӓ�(�@)ٿ��C?��f��@Jf��R�f�,%��O��� K�e+.���#'u�����	�v͝	C��l�Lم!�%�l �
z�>S�k�ڤ��9���e�gKR�l,<K� �K�X�����>:v g�a�)o�9j=7�T*�+�^���̊��	��������/L$*��]�|瘨Uj&n��IX"��+�����f�j櫺�����-�V�NV,�V*2:��:9YP��g�J�R�"G�K�-"��26���s*�wU��Nͤ�S3��X��L��w��&��Z0ik�b5��n��LD����
��I�坅���M�l��&lfW?�J��CLX6�m�YѦ�-��Ȝ��e�����E�ULD� 4;eQU�e@��&��]3��,�4��-&Ѫ��9�E�l���j.�f!��o��T-C��Q�X����f�Z�l����W,n�;Z8b��EX�K�7,T4Q�rFy�B�KS���2V�=�����[�d�#`�L9,�͑���Kř��Y
K�KSY\����Y�j�J��ۚ[�{�2�����3qql�*1���2-�޳�l&��:ß��NM��_Vj�F�v �.�r�i�^f��DJ>�p�� �Y̗��b��K���ß�G�"x )X����k[�?£���e����͵�A�Z-���J�������F�� �N��V�
��ߜ�_����w�ڧG'�[�և�7��׭�����?�l�v�r�^�]'�+o�:Q~���e>.����ҵ򱀗�<���ߌwt��S�5�fɯ���_��%��x��b�vv����=���̇Nwf��?�Bv�����c�������F��;a��C�]��� ��� wԲ���i���7}�s���G����.~�}�6�7�IH[�n��c!�����ń�;6Y�F��,.��}a� �B��;"S�
u]>	��U沉�1�?�w�џ_��iDO�D�![� PXl�x
�����i��{Cx'��ֿP���QQS~�.+��=l�.��:�zJ���]���޵'@2$�=��D���p�b��F�|xx�G&�-*%y�B���Q�+?b�r���V����vV��@!�R�R����.�M$iLIw2�7�4d�˚���R�ػ��PA �q���5v�q���	��o����-fv#AkYd1]�<\R���$�Cg�|�Ub�v�iQ���ңlf��c�1�K�b�ǚ��>��e�aD!��+��]�|we
ڨ�����H��fZ��ʩ����n<U��jԐ�8<�ٳ��h�~�N�k�/Ѽ|��(n�Y/�P�{]���ʛ�e����"��ǻR7�����W����V+�F��z�R�����$��7��7�_������Ts���~����K9���t�߹�
��$r��_V|��0~+�.+����7%�*�;UKqݕ�Mם�c�����nv��e:C'��
����?V�����d����O��.U���������!��5�$��AdS��b�d��i>�̆��X�4��pݢl0rߖ�m����]F�^��{����=aP"������ܛ���$F|E�@)"���5� h
�&伎�+�2� f��|�'���bn#��Ui�B7܎G��_�߽��ްd)=�����!Vt�(�"k�_��B��8�Կ"ї��p��ؗ���nn��}O��zpO����h7C4�;�' ��?!�?�|��Ɇ��1�rs<Ix`=��D<�Ez� $��6�l�S�b"j]ݏ"I{�~����ti0��T~Z��0ݒp�����Xg�Q�M��U.�҆>+k�CF1���"פ���ӑ�|$���2ܺ�62��j�N��QoT+5�������O���[�M�_�^�Ϝ�^/��C�˃��G�(y��.����a��=ڡ(�B��.rP�����MX�!-��$��g����fC�kԚ�o�F[�r�Kq���l"dI��'��н����v�\(�OIӶ���\Ǟa8�Td�dW��D��v����w�O&t=����ڙ�4�}/&h
\�x��*�/S`�A��x����#Tp�}���jqw%�X�YK~��S�i�w?�#/%��&e�'C�F쿣��S�K
H�}5^�O��V�>����Rg��0�Rf��0 �,
A�x�l�<H[����2eNvc6�n��o���������ʹ���QN���d��=�c����N{��4?0���?hM�X%mC��꺁��Ôڮr��*%���fd��B��(��AT�-7�в��r¤���h�Vݤ�����,w�v��k�Ը������Q��d
����hZ�N���>����8l1P��BO��Dtey�	LK��t�8���.	�f� ���2�_e�D�GYH��@Н��钬j�vN�0`&�X�^ed�LM
�%�� ~Za*2�FI���Ib0��ǯ�A�L�A�E�S�KȔ��Q��C�"���	I�,� I9E����y@z'�%�_���	oz �6���zt��O�yJ�&�X��W*�z���ʕ�����'���;oZ]��}x�.v��9"8z��[M��R\~�ui�	ڑ�~�����ޑ{&���J�TQ��H�k�߬UG}	K�dj�hl��.I��&�A1IA#`��ϙ@%ߎ���$Z�3!�iq9v聰C� �K�p�Aӓ(���g�%x�-�Y2���3y�ͽ����g�/����-M�|�d��qӺ$�b��`�=3t#E'-��O��I����-�1j���g�v�4�2}���vQ��S�R�={3i��KL<�r$I�C���W�IZ������m"�(C9��b���&H�J���!!Mq����񴟚����a��/q�,�=�L���L�\NOM"&�>���=;ێ�?�N��H�3�ܿ>�ͽ77as���m��
zl��F���\Qx=�k���־l���/��f(���\��_��Jo��F��\�����>F����1#�9
%Łv�x�8{����hY��j5���p����x��?��3[�W�O��� ��<w�}zRo--k�M6��t�&�A�^��G��A�3wv�H�q��n?��y�r��[�.�|�&�M�!���c����VA8��%Q �[��;�d���i\�W:TԻ�
�G)ʾcA��e�z7�0�v�q�-`	��I�L�|�/3�;#���-C�U"V����-�WP �1�8Hu��� ���2�^_q�Y����	�I�Giv�dI6BS!h�Q0yʇA�a�y��L�����A�C��0�/F�~$���,��!z����3�O� x��U�:dm�R�5���[-�aKh�!���\�C�o� �ủ���t�%/��< <�}C�	-qh�q��7B;b�~B�5����&�h�v�x/��%�a߱B!)���c3<��%4q(*��V|KQVC[�ٗ�$�����KVH���o�:���h��J��?Y�R����
~%�1Za��̇�;IQPLt\ _b���` �xR�7�0y(r�4u�Ǵ�A�g���Qpu�û>��Ŏ>�wb��_��M��PzLrz�i20��R���.;��)��d�Q���U!�a�B�{�hǙ&:��
�M����즉SA��&ۤ��ۓ��6�V�D��S��ԝF�q����Jc��?�c����}��
���y F�{� |90�ƕ���9 �H���e͋�T�ţ������^"����8a\=�)e���GC����IZ&�Ҏ�٬~�;|���j�$.��+m������u���Q��n,O;�y�t��*���Z2���x�\�ȍ�
��y��Ucﲹ�5�m�V<苲C*s�&�
ZJ�u0ʩ�(#o�I���$���
�ܜy���kʽ�!g���6�|���3L�F�T.Ɗ�/��JTL41��c�'s���}�W�\���O���*��򁳵���X��J�����n��oҙ)�8�FٖL&p�Tʾ��P*��۸�f�M\
0M5���-Q�J�΢�h%y�Uf�ixY!�$�,���c��ߴ����������U��?�����[ ��Fl�X��6 zBz"�?���k� ҌIs��-������5�^Ҟ��ٞ�Ӟ���JKLD�\[3�W{���y�ߩT��e�q���v�ף<�����cU�⽱kk#{���8�d�87�Y�2�j~��Zo3��	&�q�����b�c\���oG�����*���ow�/�8�L �����b�Y�#?�&�
cCG/�L�ew�/�Fn�J%B���؅"�{��"�ݘ���!?����Ŏ:��f���%�/�wU���;R�r��T٧���X�.�'�G��-�#ʇ5_�7���Ѿ;K����E N2Y��u���(y��
��v�R�:͙p+�"�G5
�o�էN�Qؗ8�b���/���?^����VjU'���V����j[��O����O,�_����f�d�/��=�Տߠ��~�r�de)�i��̝^���t�gX`�4�����E2���վE�yM���8$�����m������S��ۙJ;ɕ�r�}�J�|��t~+������]"��� 8~�r��=��-X:��LX{:)� %����#� ����<���������VP�o��|��?��>����
߷��'�?��:�E�qIX�������Ϗ����փɻ7KT`�62����F]��T����خ�<��U�:R���;��ΎY,|���]�m����ϳn��V��}vzW�^�O��v�:?gN�9.r������	�;�
�}��*��}օ�򷊻�,.�2�O�X�Z��@�� 	r����y�&�J�K J%��4vw�zz�gG�2�rNC���i0��K��ہ���18��\�[6�xj����c�5Ý��<i�y�����:g�^�U�$&e!vf���H畋�r��b4��#̭���gazq�>RL=px�M�;�y��V�Q�
�R��6� ���#.}�Q��g�C��`�<	�iE�ߧ��7�e�;��s�)e`��ڽֻs)@�5����N����������+�^��}��e��fc9oz�L`�2 ��?%ww`ޔJl�)ȟ����~�<I#%6��N H��t�(��H��c][�u���5�uz�K�U���Rl�:'ͣ+|[`�}VH�M�e�;��w��TȓV)�A[��9�U��w4ڍF5��C�F��[|>�6���/�X�^L|s���H�����[�;L���(TV�r����
x���%ƣ��/v��<��ƓW�	��������L�	4%d��m�j`�U>z��N{���9\0��fZn@��/�>��l<��q��Lp
�� p��V�;�^���ۻ��[v���m3�u�p�,�܏1Tjt�g�V��n�^��^��
Fa_�M����Q��-=~&B�ߦ~)hPOڧo��n������OP����p�Я�8�c�'�����@\�\�q�j��CpWD�YIg�I�A�����Og���C���ɥ����o���듳����I�����ӕ�{|�b|"{qnk�l6�@1֓J���2s�L�rAy�d1�ڀ6޸3߽�>CS�m�)��!���8���y]0u���|A�_�N'I���������W�p&j��,�*f}��Ohk�����aD�$���a�Ț����m����� ��P�2�3I~I��Kam[���0��!ڕ��� �apHI9�٣ 5���`����>D]8��5n�'���F1 �Xs"�]L��z���CH�Ĺ:�����$0Э�;���"F�/��d��]�i�ifED��v�/_�iiG�I� �-	���ru�I{��^�E�R�d3?K5�1w�S�k�� �7��7T1����5L�m������A*iS��6��I���&��s�|����Xe��4�sD��៬�F�D���T��)7����c<rն�����i��}��O����I0��&���Z����A���������6�G�q!��MX�
�1i:(恷2�OE�M�	��#q�ī����fZ>g�g����K	��� �% ���<���*o�ς
������@�a6u��)Հ^�x�͵RH��Y'���Z���v����c�!���O�Lk����
�?��95������9��)^n����"yd&���c<+���I�}1�,�P�ҁz��/#�AG}�'��\��]L*�{�v���D�
�u�Cy���)�_�$l�N�H�8��̋f��"M�<��K��ڝ�����h��[�G=<	�N
X�f��/�"S�'CD��:�m�1Yϼ���G����>��B\YK�|t����ǓVZ�@��3�,����;��Ud�� ������t4�$y�"��^�P)�\dѷW����n��u'��'o�����&�f��ʣE2V\��H���X-n_-�i	�dX鬛�n�ê��V7����ml<wۭ����:��r,�V��U�伕XT̨��oi���&��2�I+���	(�u���ak�0���#�0^�Ku�����ġ�2��G�`�͜�M�{(���i���>k�;��>�&8���������+�k�(w���򤱸	h��Œt�����q�Vu�5j���ϵ_��Tؠ��F�Ldw6����ET[c��EI�P���n�ʏxDh�9�cϣ�!C�}�)��������w� �ߟ��o����H"}n�}����>k=�	�ԣ � 